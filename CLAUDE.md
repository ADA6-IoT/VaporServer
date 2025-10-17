# Claude Code Agent Guidelines

이 문서는 Claude Code가 이 프로젝트에서 작업할 때 따라야 할 가이드라인입니다.

## 프로젝트 개요

이 프로젝트는 병원 IoT 디바이스 관리 시스템의 백엔드 API입니다.
- 기술 스택: Swift Vapor 4, Fluent ORM, PostgreSQL
- 아키텍처: MVC 패턴, 레이어드 아키텍처
- 주요 도메인: 병원 계정 인증, 환자 관리, 디바이스 관리, 리포트 시스템

## 프로젝트 구조

```
Sources/AppleAcademyChallenge6/
├── entrypoint.swift          # 애플리케이션 진입점
├── configure.swift           # 서버 설정 (DB, 미들웨어 등)
├── routes.swift              # 라우트 등록
├── migrationRepository.swift # 마이그레이션 관리
│
├── Controllers/              # 비즈니스 로직 컨트롤러
│   ├── Auth/                 # 인증 관련 (로그인, 토큰)
│   ├── Device/               # 디바이스 관리
│   ├── Hospital/             # 병원 계정, 리포트
│   ├── Image/                # 이미지 업로드
│   ├── Location/             # 위치 관리
│   └── Patient/              # 환자 및 병동 관리
│
├── Models/                   # Fluent 데이터베이스 모델
│   ├── HospitalAccount.swift
│   ├── Patient.swift
│   ├── Device.swift
│   ├── Report.swift
│   └── ...
│
├── DTOs/                     # 데이터 전송 객체
│   ├── Auth/
│   ├── Device/
│   ├── Patient/
│   └── Common/
│
├── Migrations/               # 데이터베이스 스키마 마이그레이션
│   ├── AuthMigration/
│   ├── Device/
│   ├── Patient/
│   ├── Report/
│   └── Image/
│
├── Routes/                   # 라우트 정의
│   ├── authRoutes.swift
│   ├── deviceRoutes.swift
│   ├── hospitalRoutes.swift
│   └── ...
│
├── Config/                   # 설정 파일
│   ├── EnvironmentConfig.swift
│   └── TokenConfig.swift
│
├── Common/                   # 공통 유틸리티
│   └── Enum/                 # 공통 열거형
│
└── Utils/                    # 유틸리티 함수
    ├── ResponseBuilder.swift
    ├── TokenGenerator.swift
    └── DataFormatter+Extension.swift
```

## 코딩 스타일

### Swift 코드 스타일
1. **들여쓰기**: 4칸 스페이스
2. **파라미터 정렬**: 파라미터가 여러 개일 때 레이블 기준으로 줄바꿈
```swift
let actionSheet = UIActionSheet(
    title: "정말 계정을 삭제하실 건가요?",
    delegate: self,
    cancelButtonTitle: "취소",
    destructiveButtonTitle: "삭제해주세요"
)
```

3. **if let 구문**: 긴 경우 줄바꿈
```swift
if let user = self.veryLongFunctionNameWhichReturnsOptionalUser(),
   let name = user.veryLongFunctionNameWhichReturnsOptionalName(),
   user.gender == .female {
    // ...
}
```

4. **주석 규칙**:
   - `// TODO: -` 나중에 작업할 부분 표시
   - `// MARK: -` 코드 섹션 구분
   - 모든 public 함수에 문서화 주석 추가

### 네이밍 컨벤션
- **타입**: PascalCase (예: `HospitalAccount`, `DeviceReport`)
- **변수/함수**: lowerCamelCase (예: `patientList`, `createDevice`)
- **데이터베이스 필드**: snake_case (예: `hospital_id`, `created_at`)

## 데이터베이스 작업

### 마이그레이션
1. 새로운 테이블 생성 시:
   - `Migrations/{Domain}/Create{TableName}.swift` 파일 생성
   - `{Domain}Migrations.swift`에 마이그레이션 등록
   - `migrationRepository.swift`에 그룹 등록

2. 마이그레이션 실행:
```bash
swift run AppleAcademyChallenge6 migrate --yes
```

### Fluent 모델
- 모든 모델은 `Model` 프로토콜 준수
- `@ID`, `@Field`, `@Parent`, `@Children` 등 프로퍼티 래퍼 활용
- 필드 키는 `FieldKey` enum으로 타입 안전하게 관리

## API 컨트롤러 작성

### 표준 구조
```swift
import Vapor
import Fluent

struct SomeController {
    // MARK: - Create
    func create(req: Request) async throws -> Response {
        // 1. DTO 디코딩
        // 2. 비즈니스 로직 수행
        // 3. ResponseBuilder로 응답 생성
    }

    // MARK: - Read
    func list(req: Request) async throws -> Response {
        // ...
    }

    // MARK: - Update
    func update(req: Request) async throws -> Response {
        // ...
    }

    // MARK: - Delete
    func delete(req: Request) async throws -> Response {
        // ...
    }
}
```

### 응답 생성
`ResponseBuilder` 유틸리티 사용:
```swift
return try await ResponseBuilder.buildSuccessResponse(
    data: resultDTO,
    on: req
)
```

## 환경 설정

### 데이터베이스
기본 설정은 `configure.swift`에 정의되어 있으며, 환경 변수로 오버라이드 가능:
- `DATABASE_HOST` (기본값: localhost)
- `DATABASE_NAME` (기본값: vapor_database)
- `DATABASE_USERNAME` (기본값: vapor_username)
- `DATABASE_PASSWORD` (기본값: vapor_password)

### 로컬 개발 시
```bash
# PostgreSQL 시작
docker compose up db -d

# 마이그레이션 실행
swift run AppleAcademyChallenge6 migrate --yes

# 서버 실행
swift run AppleAcademyChallenge6 serve --hostname 127.0.0.1 --port 8080
```

## 테스트

### 테스트 실행
```bash
# PostgreSQL이 실행 중이어야 함
docker compose up db -d

# 테스트 실행
swift test
```

### 테스트 작성 가이드
- `Testing` 프레임워크 사용
- 각 테스트는 독립적으로 실행 가능해야 함
- 테스트 전후로 마이그레이션 적용/롤백
- `TodoDTO` 등으로 응답 검증

## Git 워크플로우

### 브랜치 전략
- `main`: 제품 출시 브랜치
- `develop`: 개발 브랜치
- `feat/xx`: 새 기능 개발
- `refac/xx`: 리팩토링
- `hotfix/xx`: 긴급 버그 수정
- `chore/xx`: 빌드/설정 작업
- `design/xx`: UI/디자인 변경
- `bugfix/xx`: 버그 수정

### 커밋 메시지
형식: `{깃모지} [{태그}] {작업 내용}`

예시:
- `✨ [Feat] 환자 검색 API 구현`
- `🐛 [Fix] 디바이스 위치 업데이트 오류 수정`
- `♻️ [Refactor] 마이그레이션 코드 리팩토링`
- `📝 [Docs] API 문서 업데이트`

### 태그 종류
| 깃모지 | 태그 | 설명 |
|--------|------|------|
| ✨ | [Feat] | 새로운 기능 추가 |
| 🐛 | [Fix] | 버그 수정 |
| ♻️ | [Refactor] | 코드 리팩토링 |
| 💄 | [Style] | 코드 포맷팅 |
| 📝 | [Docs] | 문서 수정 |
| 🎉 | [Chore] | 프로젝트 초기 세팅 |
| 🚑 | [Hotfix] | 긴급 수정 |

## Pull Request

### PR 체크리스트
1. PR 유형 선택 (Feat, Fix, Refactor 등)
2. 작업 내용 상세히 작성
3. 추후 진행할 작업 명시
4. 리뷰 포인트 작성
5. 제목에 태그 포함 (예: `✨ [Feat] 환자 관리 API 구현`)

## 문제 해결

### 자주 발생하는 이슈

1. **데이터베이스 연결 실패**
   - PostgreSQL이 실행 중인지 확인: `docker compose up db -d`
   - 환경 변수 확인

2. **마이그레이션 오류**
   - 마이그레이션 롤백: `swift run AppleAcademyChallenge6 migrate --revert`
   - 다시 적용: `swift run AppleAcademyChallenge6 migrate --yes`

3. **빌드 오류**
   - 의존성 업데이트: `swift package update`
   - 캐시 정리: `swift package clean`

## Docker

### 프로덕션 빌드
```bash
# 전체 스택 실행 (DB + App)
docker compose up

# DB만 실행
docker compose up db -d

# 앱만 실행
docker compose up app
```

### 환경 변수
`docker-compose.yml`에서 `LOG_LEVEL=debug` 등 설정 가능

## 주요 작업 시 체크리스트

### 새로운 API 엔드포인트 추가
- [ ] DTO 작성 (`DTOs/` 디렉토리)
- [ ] 모델 작성 (필요시, `Models/` 디렉토리)
- [ ] 마이그레이션 작성 (필요시, `Migrations/` 디렉토리)
- [ ] 컨트롤러 작성 (`Controllers/` 디렉토리)
- [ ] 라우트 등록 (`Routes/` 디렉토리)
- [ ] `routes.swift`에 라우트 그룹 추가
- [ ] 테스트 작성
- [ ] 문서화

### 데이터베이스 스키마 변경
- [ ] 마이그레이션 파일 작성
- [ ] 마이그레이션 그룹에 등록
- [ ] `migrationRepository.swift` 업데이트
- [ ] 로컬에서 마이그레이션 테스트
- [ ] 모델 업데이트
- [ ] 관련 DTO 업데이트
- [ ] 영향받는 컨트롤러 수정

## 작업 시 주의사항

1. **보안**
   - 민감한 정보 (비밀번호, API 키)는 환경 변수로 관리
   - `.env` 파일은 `.gitignore`에 포함
   - 토큰 인증 미들웨어 적용

2. **성능**
   - N+1 쿼리 방지 (`.with()` 사용)
   - 페이지네이션 구현
   - 적절한 인덱스 설정

3. **에러 처리**
   - 명확한 에러 메시지 제공
   - HTTP 상태 코드 적절히 사용
   - 로그 레벨 적절히 설정

4. **일관성**
   - 기존 코드 스타일 따르기
   - README.md와 AGENTS.md의 컨벤션 준수
   - 네이밍 패턴 일관성 유지

## Git Hook 자동화

프로젝트에는 커밋 메시지에 깃모지를 자동으로 추가하는 Git Hook이 설정되어 있습니다.

### 사용 방법

일반적인 git commit 명령어를 사용하되, 커밋 메시지에 태그만 포함하면 됩니다:

```bash
# 태그만 포함해서 커밋
git commit -m "[Feat] 환자 검색 API 구현"

# 자동으로 깃모지가 추가됨
# ✨ [Feat] 환자 검색 API 구현
```

### 지원하는 태그

| 태그 | 깃모지 | 설명 |
|------|--------|------|
| [Feat] | ✨ | 새로운 기능 추가 |
| [Fix] | 🐛 | 버그 수정 |
| [Refactor] | ♻️ | 코드 리팩토링 |
| [Style] | 💄 | 코드 포맷팅 |
| [Docs] | 📝 | 문서 수정 |
| [Test] | ✅ | 테스트 추가/수정 |
| [Chore] | 🔧 | 빌드/설정 작업 |
| [Design] | 💄 | UI/디자인 변경 |
| [Hotfix] | 🚑 | 긴급 수정 |
| [CI/CD] | 👷 | 배포/워크플로우 |

### 주의사항

- 태그는 대소문자를 구분하지 않습니다 (`[feat]`, `[Feat]`, `[FEAT]` 모두 동일)
- 이미 깃모지가 포함된 커밋 메시지는 변경되지 않습니다
- 태그가 없는 커밋 메시지는 그대로 유지됩니다
- 커밋 후 푸시는 수동으로 해야 합니다: `git push`

### Hook 비활성화

Git Hook을 비활성화하려면:

```bash
# Hook 파일 삭제
rm .git/hooks/commit-msg

# 또는 확장자 변경으로 비활성화
mv .git/hooks/commit-msg .git/hooks/commit-msg.disabled
```

### 예시

```bash
# 일반 커밋
git add .
git commit -m "[Feat] 환자 목록 조회 API 추가"
# → ✨ [Feat] 환자 목록 조회 API 추가

git commit -m "[Fix] 디바이스 연결 오류 수정"
# → 🐛 [Fix] 디바이스 연결 오류 수정

git commit -m "[Docs] API 문서 업데이트"
# → 📝 [Docs] API 문서 업데이트

# 푸시 (수동)
git push
```
