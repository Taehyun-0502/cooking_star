# 문의 등록 및 관리자 실시간 알림 기능 설명서

## 기능 요약

사용자 또는 비회원이 `/message/create` 화면에서 문의를 작성하면 서버가 문의 내용을 DB에 저장합니다. 저장이 끝나면 서버는 WebSocket으로 `ADMIN`, `MANAGER` 권한을 가진 관리자 화면에 새 문의 알림을 보냅니다. 관리자는 상단 메뉴의 종 아이콘에서 미확인 문의 개수를 볼 수 있고, 새 문의가 들어오면 화면 오른쪽 아래에 작은 알림창이 뜹니다.

## 전체 흐름

1. 사용자가 문의 작성 화면에서 제목, 유형, 내용을 입력합니다.
2. 브라우저의 `createResult.js`가 폼을 서버의 `/message/create` 주소로 전송합니다.
3. `MessageController`가 요청을 받습니다.
4. `MessageService`가 작성자가 회원인지 비회원인지 정리하고, 읽음 상태를 `N`으로 지정합니다.
5. `MessageMapper.xml`이 `COOK_MESSAGE` 테이블에 문의를 저장합니다.
6. 저장된 문의 정보를 `MessageAlarmDTO`에 담습니다.
7. `MessageController`가 WebSocket 채널 `/topic/admin/messages`로 알림을 보냅니다.
8. 관리자/매니저 화면의 `adminAlarm.js`가 알림을 받아 배지 숫자와 알림창을 갱신합니다.

## 수정한 주요 파일

### `src/main/java/com/cooking/star/config/WebSocketConfig.java`

WebSocket을 켜는 설정 파일입니다.

- `/ws`: 브라우저가 실시간 연결을 시작하는 주소입니다.
- `/topic`: 서버가 여러 사용자에게 알림을 뿌리는 주소 앞부분입니다.
- `/app`: 브라우저가 서버로 WebSocket 메시지를 보낼 때 쓰는 주소 앞부분입니다.

이번 기능에서는 서버가 관리자에게 알림을 보내는 용도로 `/topic/admin/messages`를 사용합니다.

또한 `/ws` 연결을 시작할 때 로그인 사용자의 권한을 확인합니다. `ROLE_ADMIN` 또는 `ROLE_MANAGER`가 아니면 WebSocket 연결 자체를 허용하지 않습니다.

### `src/main/java/com/cooking/star/message/MessageController.java`

문의 관련 요청을 받는 컨트롤러입니다. 컨트롤러는 쉽게 말하면 “주소별 담당자”입니다.

- `GET /message/create`: 문의 작성 화면을 보여줍니다.
- `POST /message/create`: 문의를 DB에 저장하고 관리자에게 실시간 알림을 보냅니다.
- `GET /message/alarm/count`: 현재 미확인 문의 개수를 숫자로 돌려줍니다.
- `GET /message/list`: 관리자용 문의 목록을 보여줍니다.
- `GET /message/detail`: 문의 상세를 보여주고 읽음 처리합니다.

`SimpMessagingTemplate`은 서버에서 WebSocket 메시지를 보내기 위해 사용했습니다.

```java
messagingTemplate.convertAndSend("/topic/admin/messages", messageAlarmDTO);
```

이 코드는 “`/topic/admin/messages`를 구독 중인 브라우저들에게 `messageAlarmDTO`를 보내라”는 뜻입니다.

### `src/main/java/com/cooking/star/message/MessageService.java`

문의 저장 전후의 실제 업무 처리를 담당합니다. 서비스는 쉽게 말하면 “일 처리 담당자”입니다.

주요 역할은 다음과 같습니다.

- 로그인한 사용자는 `writerType`을 `MEMBER`로 저장합니다.
- 로그인하지 않은 비회원은 `writerType`을 `GUEST`로 저장합니다.
- 새 문의는 아직 관리자가 읽지 않았으므로 `readYn`을 `N`으로 저장합니다.
- 알림에 보여줄 작성자 이름, 제목, 내용 미리보기, 미확인 문의 개수를 만듭니다.

사용자가 조작할 수 있는 hidden input 값을 그대로 믿지 않고, 로그인 정보는 서버의 `Principal`에서 다시 확인하도록 만들었습니다.

### `src/main/java/com/cooking/star/message/MessageMapper.xml`

MyBatis가 실제 SQL을 실행하는 파일입니다.

- `create`: 문의를 `COOK_MESSAGE` 테이블에 저장합니다.
- `list`: 문의 목록을 최신순으로 가져옵니다.
- `detail`: 문의 한 건을 가져옵니다.
- `updateRead`: 상세 화면을 열면 읽음 상태를 `Y`로 바꿉니다.
- `noreadCount`: 읽지 않은 문의 개수를 셉니다.

`useGeneratedKeys="true"`를 넣어서 DB가 자동 생성한 문의 번호를 Java 코드에서도 바로 알 수 있게 했습니다. 이 번호가 있어야 알림창에서 상세 페이지로 바로 이동할 수 있습니다.

### `src/main/java/com/cooking/star/message/MessageAlarmDTO.java`

관리자 화면으로 보낼 알림 전용 데이터입니다.

DB 전체 내용을 모두 보내지 않고, 알림에 필요한 값만 담습니다.

- 문의 번호
- 작성자 구분
- 작성자 이름
- 문의 유형
- 제목
- 내용 미리보기
- 작성 시간
- 미확인 문의 개수

### `src/main/webapp/WEB-INF/views/common/navbar.jsp`

관리자와 매니저에게만 보이는 종 아이콘을 추가했습니다.

```jsp
<sec:authorize access="hasAnyRole('ADMIN','MANAGER')">
```

이 태그 안에 있는 HTML은 `ADMIN` 또는 `MANAGER` 권한이 있을 때만 화면에 나타납니다.

### `src/main/webapp/WEB-INF/views/common/scripts.jsp`

관리자와 매니저에게만 WebSocket 관련 JavaScript 파일을 불러오도록 했습니다.

- `sockjs.min.js`: 브라우저와 서버가 실시간 연결을 만들 수 있게 도와줍니다.
- `stomp.min.js`: WebSocket 메시지를 구독하고 받기 쉽게 해줍니다.
- `/js/message/adminAlarm.js`: 실제 알림 배지와 알림창을 처리하는 프로젝트 코드입니다.

### `src/main/resources/static/js/message/adminAlarm.js`

관리자 화면에서 실행되는 실시간 알림 JavaScript입니다.

처음 페이지가 열리면 `/message/alarm/count`로 미확인 문의 개수를 가져와 종 아이콘 배지에 표시합니다. 그 다음 `/ws`로 WebSocket 연결을 만들고, `/topic/admin/messages`를 구독합니다. 새 문의 알림을 받으면 배지 숫자를 바꾸고 알림창을 띄웁니다.

### `src/main/webapp/WEB-INF/views/message/create.jsp`

회원 또는 비회원이 문의를 작성하는 화면입니다.

비회원에게는 이름과 이메일 입력칸이 보이고, 로그인한 회원은 서버에서 로그인 아이디를 직접 확인하므로 화면에서 아이디를 따로 입력하지 않습니다.

### `src/main/resources/static/js/message/createResult.js`

문의 작성 폼을 비동기로 전송합니다. 전송에 성공하면 “문의가 접수되었습니다.”라는 안내를 보여주고 메인 화면으로 이동합니다.

## 권한 처리

`SecurityConfig.java`에서 다음 주소는 관리자 또는 매니저만 접근할 수 있게 했습니다.

- `/message/list`
- `/message/detail`
- `/message/alarm/count`

문의 작성 주소인 `/message/create`는 회원과 비회원 모두 사용할 수 있도록 열어두었습니다.

## DB 테이블 참고

이 기능은 기존 코드 기준으로 `COOK_MESSAGE` 테이블을 사용합니다. 테이블이 없다면 아래와 비슷한 구조가 필요합니다.

```sql
CREATE TABLE "COOK_MESSAGE" (
    "MESSAGE_NUM" BIGSERIAL PRIMARY KEY,
    "WRITER_TYPE" VARCHAR(20),
    "USERNAME" VARCHAR(100),
    "GUEST_NAME" VARCHAR(100),
    "GUEST_EMAIL" VARCHAR(200),
    "MESSAGE_TYPE" VARCHAR(30),
    "TITLE" VARCHAR(200),
    "CONTENTS" TEXT,
    "READ_YN" CHAR(1),
    "CREATE_DATE" TIMESTAMP
);
```

## 테스트 방법

1. 관리자 또는 매니저 계정으로 로그인합니다.
2. 상단 메뉴에 종 아이콘이 보이는지 확인합니다.
3. 다른 브라우저나 시크릿 창에서 `/message/create`로 들어갑니다.
4. 비회원 문의를 작성합니다.
5. 관리자 화면에서 새 문의 알림창이 뜨고 종 아이콘 숫자가 증가하는지 확인합니다.
6. 알림창의 제목 또는 `/message/list`에서 문의 상세로 들어갑니다.
7. 상세 화면을 연 뒤 목록으로 돌아오면 해당 문의가 읽음 상태가 되었는지 확인합니다.
