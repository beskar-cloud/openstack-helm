{{- define "skyline-console.template.bin._init-db.sh" -}}
#!/bin/bash

{{/*
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

   http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/}}

set -euo pipefail

mysql -h {{ .Values.mysql.host }} -u root -p{{ .Values.mysql.rootPassword }} -e "
CREATE DATABASE IF NOT EXISTS {{ .Values.mysql.database }};
CREATE USER IF NOT EXISTS '{{ .Values.mysql.user }}'@'%' IDENTIFIED BY '{{ .Values.mysql.password }}';
GRANT ALL PRIVILEGES ON {{ .Values.mysql.database }}.* TO '{{ .Values.mysql.user }}'@'%';
FLUSH PRIVILEGES;"
{{- end -}}
