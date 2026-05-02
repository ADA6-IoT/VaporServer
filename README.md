# VaporServer (AppleAcademyChallenge6)

> **FindU** 백엔드 — 병원 환자 실내 위치 추적 시스템의 REST API 서버.
> Apple Developer Academy @ POSTECH 6기 챌린지 프로젝트.

ESP32-C6 비콘에서 수집된 위치 데이터를 처리하고, iOS 앱(Findew)에 실시간 위치/통계를 제공하는 Vapor 4 기반 백엔드.

## 🧩 프로젝트 구성 (FindU 생태계)

| 컴포넌트 | 역할 | 레포 |
|---------|------|------|
| ESP32-C6 펌웨어 | FTM/ESP-NOW 위치 비콘·게이트웨이 | `ADA6-IoT/SwiftEmbedded` |
| **VaporServer (이 레포)** | REST API + JWT + PostgreSQL + S3 | `ADA6-IoT/VaporServer` |
| Findew iOS 앱 | 의료진 모니터링 클라이언트 | `ADA6-IoT/SwiftUIApp` |

## 🏥 도메인 모델

병원 행정·운영 + 실내 위치 추적이 통합된 스키마.

| 도메인 | 설명 |
|--------|------|
| **Hospital / Department / Room** | 병원 → 부서 → 병실 계층 |
| **Patient** | 환자 정보 + 디바이스 매핑 |
| **Device** | 환자 착용 비콘(ESP32-C6) |
| **Anchor** | 게이트웨이 (FTM Responder) — 병실에 설치 |
| **Location** | FTM 거리 측정 결과로 계산된 환자 위치 |
| **Auth** | 의료진/관리자 계정 (JWT) |
| **Dashboard / Report / ErrorLog** | 통계·리포트·오류 로그 |

## 🛠 기술 스택

- **Framework**: [Vapor 4](https://vapor.codes/) (Swift 6.0+)
- **ORM**: Fluent + PostgreSQL Driver
- **DB**: PostgreSQL 18
- **Auth**: JWT (`vapor/jwt`)
- **Storage**: AWS S3 ([Soto](https://github.com/soto-project/soto))
- **API Docs**: [VaporToOpenAPI](https://github.com/dankinsoid/VaporToOpenAPI) (Swagger UI 자동 생성)
- **Deploy**: Docker + docker-compose

## 🚀 실행 방법

### 사전 요구사항
- Swift 6.0+ (또는 Docker만)
- PostgreSQL 18 (Docker로 띄우면 자동)
- AWS S3 자격증명 (이미지 업로드용)

### 1️⃣ 환경변수 설정

루트에 `.env` 생성:
```bash
LOG_LEVEL=info
DATABASE_HOST=localhost
DATABASE_PORT=5432
DATABASE_USERNAME=admin
DATABASE_PASSWORD=YOUR_DB_PASSWORD
DATABASE_NAME=FindU_db

JWT_SECRET=YOUR_JWT_SECRET_HERE
JWT_EXPIRATION_SECONDS=3600

AWS_ACCESS_KEY_ID=YOUR_AWS_KEY
AWS_SECRET_ACCESS_KEY=YOUR_AWS_SECRET
AWS_S3_BUCKET=your-bucket-name

SERVER_URL=http://localhost:8080
```

### 2️⃣ Docker로 한 번에 실행 (권장)

```bash
# PostgreSQL + 서버 + 마이그레이션 모두 자동
docker compose up app

# 마이그레이션만 따로 실행
docker compose run migrate

# 마이그레이션 롤백
docker compose run revert

# 종료 + DB 데이터 삭제
docker compose down -v
```

서버: `http://localhost:8080`

### 3️⃣ 로컬 Swift 빌드

```bash
# 의존성 설치 + 빌드
swift build

# DB 마이그레이션
swift run AppleAcademyChallenge6 migrate --yes

# 서버 실행 (개발 모드)
swift run AppleAcademyChallenge6 serve --hostname 0.0.0.0 --port 8080

# 프로덕션 모드
swift run AppleAcademyChallenge6 serve --env production --hostname 0.0.0.0 --port 8080
```

## 🌐 API 엔드포인트

| Path | 설명 |
|------|------|
| `GET /ping` | 헬스 체크 |
| `GET /docs` | Swagger UI 리다이렉트 |
| `GET /openapi` | OpenAPI JSON 스펙 |
| `/auth/...` | 로그인·토큰 갱신 |
| `/patients/...` | 환자 CRUD |
| `/devices/...` | 디바이스(비콘) CRUD |
| `/anchors/...` | 게이트웨이 등록·관리 |
| `/rooms/...`, `/departments/...` | 병원 행정 단위 |
| `/locations/...` | 위치 데이터 수신·조회 (`POST /api/locations/calculate` 등) |
| `/dashboard/...` | 의료진 대시보드 |
| `/reports/...` | 리포트 |
| `/error-logs/...` | 에러 로그 |

전체 스펙은 서버 실행 후 `http://localhost:8080/docs` 에서 확인.

## 🗂 프로젝트 구조

```
Sources/AppleAcademyChallenge6/
├── App.swift                # @main 진입점
├── configure.swift          # 앱 설정 (DB/JWT/S3/CORS/Migration)
├── routes.swift             # 라우트 등록
├── Config/                  # CORS, Database, JWT, Middleware, Migration, OpenAPI 설정
├── Controllers/             # Auth/Anchor/Dashboard/Department/Device/ErrorLog/Location/Patient/Report/Room
├── DTOs/                    # 도메인별 요청/응답 DTO
├── Model/                   # Fluent 모델 (DB 스키마)
├── Migration/               # DB 마이그레이션 스크립트
├── Middleware/              # 인증/권한 미들웨어
├── Services/                # 비즈니스 로직 (S3Service 포함)
├── Extension/               # Swift 확장
└── Utils/                   # 유틸리티

Public/                      # 정적 파일 (Swagger UI 등)
Tests/                       # 테스트
Dockerfile                   # 빌드 이미지 (swift:6.2-noble)
docker-compose.yml           # app + db + migrate 통합
```

## 🔖 브랜치 컨벤션
* `main` - 제품 출시 브랜치
* `develop` - 출시를 위해 개발하는 브랜치
* `feat/xx` - 기능 단위로 독립적인 개발 환경을 위해 작성
* `refac/xx` - 개발된 기능을 리팩토링 하기 위해 작성
* `hotfix/xx` - 출시 버전에서 발생한 버그를 수정하는 브랜치
* `chore/xx` - 빌드 작업, 패키지 매니저 설정 등
* `bugfix/xx` - 버그 수정

## 🌀 코딩 컨벤션

* 파라미터 이름을 기준으로 줄바꿈 한다.
* `if let` 구문이 길 경우 줄바꿈 한다.
* 추가 작업 부분: `// TODO: - xxx`
* 코드 섹션 분리: `// MARK: - xxx`
* 함수에는 액션을 알 수 있는 주석 작성

## 📑 커밋 컨벤션

### 🏷️ 태그
| 태그 | 설명 |
|------|------|
| `[Feat]` | 새로운 기능 추가 |
| `[Fix]` | 버그 수정 |
| `[Refactor]` | 코드 리팩토링 |
| `[Style]` | 코드 포맷팅 |
| `[Docs]` | README, 문서 수정 |
| `[Test]` | 테스트 코드 |
| `[Chore]` | 패키지/빌드 설정 |
| `[Hotfix]` | 운영 중 긴급 수정 |
| `[CI/CD]` | 배포·워크플로우 |

### 💬 자주 쓰는 깃모지

| 아이콘 | 용도 | | 아이콘 | 용도 |
|:---:|---|:---:|:---:|---|
| 🎉 | 프로젝트 시작 | | 📝 | 문서 |
| ✨ | 새 기능 | | 🐛 | 버그 수정 |
| ♻️ | 리팩토링 | | 🔧 | 설정 |
| 🚑 | 긴급 수정 | | ⚡️ | 성능 |
| 🔥 | 코드 삭제 | | ➕ | 의존성 |
| 🙈 | .gitignore | | 🚚 | 이름 변경 |

### ✅ 예시
> 🎉 [Chore] 프로젝트 초기 세팅
> ✨ [Feat] 환자 위치 계산 API 구현
> 🐛 [Fix] JWT 만료 시 401 응답 누락
> ♻️ [Refactor] LocationController 서비스 분리
> 📝 [Docs] OpenAPI 스펙 추가

## 👥 팀

ADA6-IoT — Apple Developer Academy @ POSTECH 6기

## 📄 라이선스

MIT License — 자세한 내용은 [LICENSE](./LICENSE) 참고.
