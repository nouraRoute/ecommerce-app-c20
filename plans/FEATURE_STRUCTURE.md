# New Feature Plan — Domain & Data Layers

This is the reusable plan for adding a feature to this app. It takes a feature from an API
contract to a compiled, dependency-injected **domain + data** layer, and stops at the domain
boundary. The presentation layer (cubit, states, screens, routes) is a separate plan that
consumes what this one delivers.

The reference implementation is the `auth` feature (`lib/features/auth`). Every template below
has a matching real file there.

---

## 1. Required inputs — ask for these before writing any code

Do not start until every item below has an answer. Collect the **feature** block once and the
**action** block once per API call the feature makes (login, register, get categories, …).

### Feature

1. **Feature name** — snake_case, e.g. `auth`, `categories`, `cart`.
2. **Actions** — the list of operations this feature performs. Each one becomes a use case.

### Per action

3. **HTTP method and endpoint path** — e.g. `POST /auth/signin`, `GET /categories`, `GET /products/{id}`.
4. **Parameters** — path params, query params, required headers (e.g. a `token` header). Say "none" if none.
5. **Request JSON** — the exact body sent, as a sample. Say "none" for calls without a body.
6. **Response JSON** — the exact success body, as a sample, including nesting and wrapper keys.
   Error bodies follow the server's `{ "message": "..." }` shape and are already handled by `ErrorModel`;
   only mention them if this endpoint deviates.
7. **Entity for presentation** — the fields the UI will actually display or use from this action:
   each field's name, Dart type, and which response key it comes from.
   The entity is designed from this list, **not** from the full response JSON.

### Fill-in template

Copy this into the ticket or PR and complete it.

```
Feature name:   
Actions:        

=== Action: <action name> ===
Method + path:          
Parameters:             (path / query / headers, or none)
Request JSON:           (sample body, or none)
Response JSON:          (sample success body)
Entity for presentation:
  - <fieldName> (<Type>)   <- <response.key.path>
  - <fieldName> (<Type>)   <- <response.key.path>
```

### Worked example — `auth` / `login`

```
Feature name:   auth
Actions:        login

=== Action: login ===
Method + path:          POST /auth/signin
Parameters:             none
Request JSON:           { "email": "user@mail.com", "password": "secret" }
Response JSON:          { "message": "success",
                          "user": { "name": "Noura", "email": "user@mail.com", "role": "user" },
                          "token": "eyJhbGciOi..." }
Entity for presentation:
  - email (String)   <- user.email
  - name  (String)   <- user.name
```

This produced `LoginRequestModel`, `LoginResponseModel` (wrapper), `UserResponseModel` (nested
object, owns `toDomain()`), and `UserEntity` with only the fields the screen needed.

---

## 2. Placeholder tokens

Templates in this plan use these tokens. Replace every one of them.

| Token | Meaning | `auth` value |
|---|---|---|
| `{feature}` / `{Feature}` | feature name, snake_case / PascalCase | `auth` / `Auth` |
| `{action}` / `{Action}` | action name, camelCase / PascalCase | `login` / `Login` |
| `{thing}` / `{Thing}` | the domain object an action deals with | `user` / `User` |
| `{ReturnType}` | what the action returns to the domain | `UserEntity?` |
| `{input}` | the domain-level parameters of the action | `UserEntity user` |

`_$` in generated-code references (`_$LoginResponseModelFromJson`) is the `json_serializable` prefix,
not a token. `{id}` inside an endpoint path is Retrofit path syntax, not a token.

---

## 3. Architecture and where this plan stops

```
presentation  ──►  domain  ◄──  data
 (out of scope)    (entity,      (API, models,
                    repo contract, data source,
                    use case)     repo implementation)
```

Dependencies point inward only. `data` depends on `domain`; `domain` depends on nothing inside the
feature except `core`. `presentation` will later depend on `domain` only.

Call chain this plan builds, bottom-up from the network:

```
{Action}Usecase              domain/usecases          ◄── presentation will call this
  └─► {Feature}Repo          domain/repository        (abstract)
        └─► {Feature}RepoImpl          data/repository
              └─► {Feature}DataSource  data/data_source   (abstract)
                    └─► {Feature}RemoteDataSource         data/data_source
                          └─► {Feature}Api                data/api (Retrofit)
                                └─► Dio                   core/di/module/dio.module.dart
```

| Rule | Where it is enforced |
|---|---|
| Domain never imports data models | `domain/` files import only `core/` and other `domain/` files |
| Data models convert to and from entities | `toDomain()` on response models, `fromDomain()` on request models |
| Repositories never throw | `{Feature}RepoImpl` wraps every call in `try/catch` and returns `Success` or `Failure` |
| Errors are normalised in one place | `ErrorModel.errorHandler(e)` in `core/error/error_model.dart` |
| Everything is injected | every class carries an `injectable` annotation and is resolved through `getIt` |

**The plan is done when** the use case(s), entity, repo contract and the whole data layer compile,
are registered in `di.config.dart`, and `flutter analyze` is clean. Nothing under `presentation/`
is created here.

---

## 4. Folder template

Create only the `data/` and `domain/` trees. Leave `presentation/` for the presentation plan.

```
lib/features/{feature}/
├── data/
│   ├── api/
│   │   └── {feature}_api.dart                 Retrofit interface (+ generated .g.dart)
│   ├── data_source/
│   │   └── {feature}_data_source.dart         abstract contract + Remote implementation
│   ├── model/
│   │   ├── request_models/
│   │   │   └── {action}_request_model.dart    from input 5 (+ .g.dart) — only when there is a body
│   │   └── response_models/
│   │       ├── {action}_response_model.dart   from input 6, the top-level wrapper (+ .g.dart)
│   │       └── {thing}_response_model.dart    from input 6, one per nested object (+ .g.dart)
│   └── repository/
│       └── {feature}_repo_impl.dart           implements the domain contract
└── domain/
    ├── entity/
    │   └── {thing}_entity.dart                from input 7
    ├── repository/
    │   └── {feature}_repo.dart                abstract, one method per action
    └── usecases/
        └── {action}_usecase.dart              one per action, exposes call()
```

Core files this plan also touches:

| File | Change |
|---|---|
| `lib/core/network/endpoints.dart` | add one path constant per action |
| `lib/core/di/di.config.dart` | **never edit by hand** — regenerated by `build_runner` |

---

## 5. Derivation rules — from inputs to code

### 5.1 Response JSON (input 6) → response models

- The top-level object becomes `{Action}ResponseModel`. It is a wrapper and usually has no `toDomain()`.
- Every nested object becomes its own `{Thing}ResponseModel` in its own file. The one that represents
  the domain object owns `toDomain()`.
- Every JSON key becomes a nullable field with `@JsonKey(name: '<json key>')`, even when the names match.
- Field names are camelCase in Dart regardless of the JSON key (`_id` → `id`, `imageCover` → `imageCover`).

| JSON value | Dart field |
|---|---|
| `"text"` | `String?` |
| `12` | `int?` |
| `12.5` | `num?` |
| `true` | `bool?` |
| `{ ... }` | `{Thing}ResponseModel?` (new file) |
| `[ { ... } ]` | `List<{Thing}ResponseModel>?` (new file for the item) |
| `[ "a", "b" ]` | `List<String>?` |

### 5.2 Request JSON (input 5) → request model

- Only when the action sends a body. Path, query and header parameters go straight on the API method.
- Fields are `final` and `required` (the caller must supply all of them), with `@JsonKey` where the key differs.
- Provide `static {Action}RequestModel fromDomain({input})` so the repo implementation builds it from
  domain input and the data source never sees an entity.

### 5.3 Entity for presentation (input 7) → entity

- One plain Dart class per domain object. No annotations, no JSON, no imports from `data/`.
- Contains **exactly** the fields listed in input 7. Do not add response fields "in case they are needed".
- Fields are nullable; nested response fields are flattened (`user.name` → `name`).
- If several actions deal with the same object (login and register both return a user), they share one entity.
- Input fields the action needs (e.g. `password` for login) also live on the entity so `fromDomain()` can read them.

### 5.4 Action (inputs 3–4) → contract signatures

| Action shape | Repo / use case `{input}` | API method parameters |
|---|---|---|
| GET, no params | none | none |
| GET by id / with filters | `String id`, `int? limit` | `@Path('id') String id`, `@Query('limit') int? limit` |
| POST / PUT with body | `{Thing}Entity {thing}` | `@Body() {Action}RequestModel requestModel` |
| Needs an auth header | pass through from the caller | `@Header('token') String token` |

`{ReturnType}` is `{Thing}Entity?` for single-object responses, `List<{Thing}Entity>` for lists, and
`void` when the presentation only needs success/failure.

The current `DioModule` has no auth interceptor. If an action needs a token header, record it in
input 4 and use `@Header`; adding an interceptor is a `core` change outside this plan.

---

## 6. Steps

Work domain-first so the data layer has a contract to implement. Reference files are in `lib/features/auth`.

### Step 1 — Endpoint constant

`lib/core/network/endpoints.dart`

```dart
class Endpoints {
  static const String loginEndpoint = '/auth/signin';
  static const String {action}Endpoint = '/{path from input 3}';   // keep {id} for Retrofit path params
}
```

### Step 2 — Domain: entity (from input 7)

`lib/features/{feature}/domain/entity/{thing}_entity.dart` — reference: `domain/entity/user_entity.dart`

```dart
class {Thing}Entity {
  String? id;
  String? {fieldOne};
  int? {fieldTwo};

  {Thing}Entity({this.id, this.{fieldOne}, this.{fieldTwo}});
}
```

### Step 3 — Domain: repository contract

`lib/features/{feature}/domain/repository/{feature}_repo.dart` — reference: `domain/repository/auth_repo.dart`

One method per action. Every method returns `Future<Response<...>>` using the sealed `Response`
from `core/network/models/response_model.dart`, and only ever exposes entities.

```dart
import 'package:ecommerce_app/core/network/models/response_model.dart';
import 'package:ecommerce_app/features/{feature}/domain/entity/{thing}_entity.dart';

abstract class {Feature}Repo {
  Future<Response<{ReturnType}>> {action}({input});
}
```

### Step 4 — Domain: use case

`lib/features/{feature}/domain/usecases/{action}_usecase.dart` — reference: `domain/usecases/login_usecase.dart`

One class per action. `@injectable`, depends on the **abstract** repo through a named parameter,
exposes `call()` so the presentation layer can invoke it like a function.

```dart
import 'package:ecommerce_app/core/network/models/response_model.dart';
import 'package:ecommerce_app/features/{feature}/domain/entity/{thing}_entity.dart';
import 'package:ecommerce_app/features/{feature}/domain/repository/{feature}_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class {Action}Usecase {
  final {Feature}Repo _{feature}Repo;

  {Action}Usecase({required {Feature}Repo {feature}Repo}) : _{feature}Repo = {feature}Repo;

  Future<Response<{ReturnType}>> call({input}) async => await _{feature}Repo.{action}({args});
}
```

### Step 5 — Data: response models (from input 6)

Nested object — `lib/features/{feature}/data/model/response_models/{thing}_response_model.dart`
— reference: `data/model/response_models/user_response_model.dart`

```dart
import 'package:ecommerce_app/features/{feature}/domain/entity/{thing}_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part '{thing}_response_model.g.dart';

@JsonSerializable()
class {Thing}ResponseModel {
  @JsonKey(name: '_id')
  String? id;
  @JsonKey(name: '{json_key}')
  String? {fieldOne};
  @JsonKey(name: '{json_key}')
  int? {fieldTwo};

  {Thing}ResponseModel({this.id, this.{fieldOne}, this.{fieldTwo}});

  factory {Thing}ResponseModel.fromJson(Map<String, dynamic> json) => _${Thing}ResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _${Thing}ResponseModelToJson(this);

  {Thing}Entity toDomain() => {Thing}Entity(id: id, {fieldOne}: {fieldOne}, {fieldTwo}: {fieldTwo});
}
```

Top-level wrapper — `lib/features/{feature}/data/model/response_models/{action}_response_model.dart`
— reference: `data/model/response_models/login_response_model.dart`

```dart
import 'package:ecommerce_app/features/{feature}/data/model/response_models/{thing}_response_model.dart';
import 'package:json_annotation/json_annotation.dart';

part '{action}_response_model.g.dart';

@JsonSerializable()
class {Action}ResponseModel {
  @JsonKey(name: 'message')
  String? message;
  @JsonKey(name: '{json_key}')
  {Thing}ResponseModel? {thing};            // single object …
  @JsonKey(name: 'data')
  List<{Thing}ResponseModel>? data;         // … or a list; keep whichever input 6 shows

  {Action}ResponseModel({this.message, this.{thing}, this.data});

  factory {Action}ResponseModel.fromJson(Map<String, dynamic> json) => _${Action}ResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _${Action}ResponseModelToJson(this);
}
```

### Step 6 — Data: request model (from input 5, only when there is a body)

`lib/features/{feature}/data/model/request_models/{action}_request_model.dart`
— reference: `data/model/request_models/login_request_model.dart`

```dart
import 'package:ecommerce_app/features/{feature}/domain/entity/{thing}_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part '{action}_request_model.g.dart';

@JsonSerializable()
class {Action}RequestModel {
  final String {fieldOne};
  final String {fieldTwo};

  {Action}RequestModel({required this.{fieldOne}, required this.{fieldTwo}});

  factory {Action}RequestModel.fromJson(Map<String, dynamic> json) => _${Action}RequestModelFromJson(json);

  Map<String, dynamic> toJson() => _${Action}RequestModelToJson(this);

  static {Action}RequestModel fromDomain({Thing}Entity {thing}) =>
      {Action}RequestModel({fieldOne}: {thing}.{fieldOne} ?? '', {fieldTwo}: {thing}.{fieldTwo} ?? '');
}
```

### Step 7 — Data: Retrofit API

`lib/features/{feature}/data/api/{feature}_api.dart` — reference: `data/api/auth_api.dart`

Three annotations are mandatory: `@injectable` (DI registration), `@RestApi()` (Retrofit), and
`@factoryMethod` on the factory so `injectable` constructs it with the shared `Dio`. One method per action.

```dart
import 'package:dio/dio.dart';
import 'package:ecommerce_app/core/network/endpoints.dart';
import 'package:ecommerce_app/features/{feature}/data/model/request_models/{action}_request_model.dart';
import 'package:ecommerce_app/features/{feature}/data/model/response_models/{action}_response_model.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part '{feature}_api.g.dart';

@injectable
@RestApi()
abstract class {Feature}Api {
  @factoryMethod
  factory {Feature}Api(Dio dio) = _{Feature}Api;

  // GET, no parameters
  @GET(Endpoints.{action}Endpoint)
  Future<{Action}ResponseModel> {action}();

  // GET with path / query parameters  (endpoint constant contains '{id}')
  @GET(Endpoints.{action}Endpoint)
  Future<{Action}ResponseModel> {action}(@Path('id') String id, @Query('limit') int? limit);

  // POST with body
  @POST(Endpoints.{action}Endpoint)
  Future<{Action}ResponseModel> {action}(@Body() {Action}RequestModel requestModel);
}
```

Keep only the variant that matches inputs 3–5 for each action.

### Step 8 — Data: data source

`lib/features/{feature}/data/data_source/{feature}_data_source.dart` — reference: `data/data_source/auth_data_source.dart`

Abstract contract and `Remote` implementation in the same file. The implementation only forwards to
the API: no mapping, no error handling, no entities.

```dart
import 'package:ecommerce_app/features/{feature}/data/api/{feature}_api.dart';
import 'package:ecommerce_app/features/{feature}/data/model/request_models/{action}_request_model.dart';
import 'package:ecommerce_app/features/{feature}/data/model/response_models/{action}_response_model.dart';
import 'package:injectable/injectable.dart';

abstract class {Feature}DataSource {
  Future<{Action}ResponseModel> {action}({Action}RequestModel requestModel);
}

@Injectable(as: {Feature}DataSource)
class {Feature}RemoteDataSource implements {Feature}DataSource {
  final {Feature}Api _{feature}Api;

  {Feature}RemoteDataSource({required {Feature}Api {feature}Api}) : _{feature}Api = {feature}Api;

  @override
  Future<{Action}ResponseModel> {action}({Action}RequestModel requestModel) async =>
      await _{feature}Api.{action}(requestModel);
}
```

### Step 9 — Data: repository implementation

`lib/features/{feature}/data/repository/{feature}_repo_impl.dart` — reference: `data/repository/auth_repo_impl.dart`

The only place that catches exceptions and the only place that converts models to entities.

```dart
import 'package:ecommerce_app/core/error/error_model.dart';
import 'package:ecommerce_app/core/network/models/response_model.dart';
import 'package:ecommerce_app/features/{feature}/data/data_source/{feature}_data_source.dart';
import 'package:ecommerce_app/features/{feature}/data/model/request_models/{action}_request_model.dart';
import 'package:ecommerce_app/features/{feature}/data/model/response_models/{action}_response_model.dart';
import 'package:ecommerce_app/features/{feature}/domain/entity/{thing}_entity.dart';
import 'package:ecommerce_app/features/{feature}/domain/repository/{feature}_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: {Feature}Repo)
class {Feature}RepoImpl implements {Feature}Repo {
  final {Feature}DataSource _{feature}DataSource;

  {Feature}RepoImpl({required {Feature}DataSource {feature}DataSource})
      : _{feature}DataSource = {feature}DataSource;

  @override
  Future<Response<{ReturnType}>> {action}({input}) async {
    try {
      {Action}ResponseModel responseModel =
          await _{feature}DataSource.{action}({Action}RequestModel.fromDomain({thing}));

      // single object:
      {Thing}Entity? result = responseModel.{thing}?.toDomain();
      // list:
      // List<{Thing}Entity> result = responseModel.data?.map((model) => model.toDomain()).toList() ?? [];

      return Success(data: result);
    } catch (e) {
      ErrorModel error = ErrorModel.errorHandler(e);
      return Failure(errorModel: error);
    }
  }
}
```

### Step 10 — Generate, analyse, verify

Three generators run from one command: `json_serializable` (model `.g.dart`), `retrofit_generator`
(API `.g.dart`), `injectable_generator` (`core/di/di.config.dart`).

```bash
dart run build_runner build --delete-conflicting-outputs
flutter analyze
```

Generated files are committed (they are not in `.gitignore`); commit the new `.g.dart` files and
the updated `di.config.dart` with the feature.

Open `lib/core/di/di.config.dart` and confirm it registers, for this feature:
`{Feature}Api`, `{Feature}DataSource` → `{Feature}RemoteDataSource`, `{Feature}Repo` → `{Feature}RepoImpl`,
and one `{Action}Usecase` per action. A missing entry means a missing `@injectable` /
`@Injectable(as: …)` annotation, or a missing `@factoryMethod` on the Retrofit factory.

---

## 7. Handoff to the presentation plan

This plan delivers, per action, everything the presentation layer needs and nothing it should not see:

| Delivered | How presentation uses it |
|---|---|
| `{Action}Usecase`, registered in DI | injected into a cubit as `required {Action}Usecase`; invoked as `await _usecase({args})` |
| `Future<Response<{ReturnType}>> call({input})` | `switch (response) { case Success(): response.data; case Failure(): response.errorModel.message; }` |
| `{Thing}Entity` with exactly the fields from input 7 | rendered directly; no model types leak upward |

Out of scope for this plan, and not to be created here: `presentation/view_model/` (cubit, states),
`presentation/view/` (screens, widgets), entries in `core/routes_manager/`, dialogs, and resources.

---

## 8. Checklist

- [ ] Inputs 1–7 collected and recorded for every action (section 1 template)
- [ ] Endpoint constant(s) added to `core/network/endpoints.dart`
- [ ] `domain/entity/{thing}_entity.dart` — plain class, fields = input 7 only
- [ ] `domain/repository/{feature}_repo.dart` — abstract, one method per action, returns `Future<Response<…>>`
- [ ] `domain/usecases/{action}_usecase.dart` — one per action, `@injectable`, exposes `call()`
- [ ] `data/model/response_models/` — wrapper + one model per nested object, `@JsonKey` on every field, `toDomain()` on the domain object
- [ ] `data/model/request_models/` — only for actions with a body; `fromDomain()`
- [ ] `data/api/{feature}_api.dart` — `@injectable` + `@RestApi()` + `@factoryMethod`, one method per action
- [ ] `data/data_source/{feature}_data_source.dart` — abstract + `@Injectable(as:)` Remote impl, forward-only
- [ ] `data/repository/{feature}_repo_impl.dart` — `@Injectable(as:)`, `try/catch` → `Success` / `Failure`
- [ ] No file under `domain/` imports from `data/`; no file under `presentation/` created
- [ ] `dart run build_runner build --delete-conflicting-outputs` succeeded; generated files committed
- [ ] `di.config.dart` lists the API, data source, repo and every use case
- [ ] `flutter analyze` clean

---

## 9. Conventions reference

### Naming

| Thing | Pattern | `auth` example |
|---|---|---|
| Feature folder | `snake_case` | `auth` |
| Retrofit API | `{Feature}Api` | `AuthApi` |
| Data source contract / impl | `{Feature}DataSource` / `{Feature}RemoteDataSource` | `AuthDataSource` / `AuthRemoteDataSource` |
| Request model | `{Action}RequestModel` | `LoginRequestModel` |
| Response wrapper | `{Action}ResponseModel` | `LoginResponseModel` |
| Nested response object | `{Thing}ResponseModel` | `UserResponseModel` |
| Repo contract / impl | `{Feature}Repo` / `{Feature}RepoImpl` | `AuthRepo` / `AuthRepoImpl` |
| Entity | `{Thing}Entity` | `UserEntity` |
| Use case | `{Action}Usecase` | `LoginUsecase` |
| Endpoint constant | `{action}Endpoint` | `loginEndpoint` |

### Dependency injection

- Concrete classes with no abstraction (use cases): `@injectable`.
- Implementations bound to an interface (data sources, repos): `@Injectable(as: Interface)`.
- Retrofit APIs: `@injectable` + `@RestApi()` on the class, `@factoryMethod` on the factory taking `Dio`.
- Constructors take dependencies as **named required parameters** stored in private fields.
  Depend on the abstraction (`{Feature}Repo`), never the implementation (`{Feature}RepoImpl`).
- `Dio` is the singleton from `core/di/module/dio.module.dart` with `AppConstants.baseUrl`. Never create another.
- Nothing in `domain/` or `data/` calls `getIt`. Resolution happens only at the presentation edge.

### Error handling

- `ErrorModel.errorHandler(e)` turns any thrown object into a sealed `ErrorModel` subclass
  (`NetworkError`, `AuthError`, `RequestError`, `ServerError`, `TypeParseError`, `GeneralError`) and
  surfaces the server's `message` when present.
- Only `{Feature}RepoImpl` calls it. Use cases and everything above them only see `Success` / `Failure`.

### Models and entities

- Response model fields are nullable with `@JsonKey(name: …)`; request model fields are `final` and `required`.
- Entities are plain classes and the only types that cross from `data` into `domain`.
- Conversion lives on the model: `toDomain()` on response models, `fromDomain()` on request models.

---

## 10. Core files this plan depends on

| Path | Purpose |
|---|---|
| `core/di/di.dart` | `getIt` instance and `configureDependencies()` called from `main.dart` |
| `core/di/module/dio.module.dart` | shared `Dio` singleton with the base URL |
| `core/network/endpoints.dart` | all endpoint paths |
| `core/network/models/response_model.dart` | sealed `Response<T>` with `Success` and `Failure` |
| `core/error/error_model.dart` | sealed `ErrorModel` hierarchy and `errorHandler` |
