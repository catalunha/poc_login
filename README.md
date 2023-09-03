# poc_login

Testando login com DjangoREST

## Getting Started
No terminal do projeto:
dart run build_runner watch -d

Mantenha o runserver da api ativa 

# History
catalunha@pop-os:~/myapp/pocs$ flutter create --project-name poc_login --platforms android,web,linux ./poc_login

A API deste projeto se encontra em:
`/home/catalunha/myapp/pocs/poc_login_api`

## PubSpec packages
Copie os seguintes comandos no terminal do projeto:
```
flutter pub add \
  flutter_riverpod \
  riverpod_annotation \
  dev:riverpod_generator \
  dev:build_runner \
  dev:custom_lint \
  dev:riverpod_lint

flutter pub add \
  dio \
  freezed_annotation \
  json_annotation \
  go_router \
  image_picker \
  file_picker \
  validatorless \
  intl \
  url_launcher

flutter pub add \
  dev:freezed \
  dev:json_serializable
```

## analysis_options.yaml
Copia as linhas a seguir no arquivo analysis_options.yaml
```
# Riverpod
analyzer:
  plugins:
    - custom_lint
```

catalunha@pop-os:~/myapp/pocs/poc_login$ dart run build_runner watch -d