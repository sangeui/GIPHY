GIPHY
---

다음과 같은 기능을 제공합니다.

- 현재 GIPHY 네트워크 상에서 가장 활발한 검색어 목록을 제공합니다
- 사용자가 한번 이상 사용한 검색어를 제공합니다.
- 가능한 검색 결과 종류, `GIFs`와 `Stickers`를 제공합니다.

<p align="center">
<img src="https://user-images.githubusercontent.com/34618339/142764079-58704d12-301b-41ff-a222-0e86063dfa0b.PNG" alt="drawing" width="200"/>
</p>

---

- 검색 결과를 각 이미지의 비율에 맞춰, 두 칼럼에 균형 있게 채워져 보여줍니다. (#PinterestGridLayout #StaggeredGridLayout)
- 검색 결과가 나타난 상태에서 결과 종류를 변경하면, 현재 검색어로 다시 결과를 보여줍니다.

<p align="center">
<img src="https://user-images.githubusercontent.com/34618339/142764250-3a4386ef-cc2a-4423-88fc-876d74119421.PNG" alt="drawing" width="200"/>
<img src="https://user-images.githubusercontent.com/34618339/142764314-287dd684-e09d-44be-b5d1-f74b1e7d7a1d.PNG" alt="drawing" width="200"/>
</p>

---

- 간단한 상세 화면을 제공합니다.
- 상세 화면에서는 해당 이미지의 유저 정보를 확인할 수 있습니다.
- 좌측의 `좋아요 또는 추천 버튼`을 통해 해당 이미지에 대한 선호 상태를 변경할 수 있습니다.

<p align="center">
<img src="https://user-images.githubusercontent.com/34618339/142764412-7563641c-c401-45c1-bff9-d0f99867b4d6.PNG" alt="drawing" width="200"/>
</p>

---

다음과 같은 구조를 따르도록 개발했습니다.

<p align="center">
<img src="https://user-images.githubusercontent.com/34618339/142764459-50c860ae-950a-40cc-a7fa-d6c040aafd34.png" alt="drawing" width=""/>
</p>

- **Use Case** 는 앱에서 제공하는 기능 또는 유스 케이스를 지원합니다.
	- 기능 별로 유스 케이스를 구성했습니다.
	- 유스 케이스에서 GIPHY API와 같은 외부 서비스가 필요하면 레이어 내부에 인터페이스를 제공하여, 외부 서비스가 이를 종속하도록 구성했습니다.
		- 이로써 의존성을 역전 시켰습니다.
- **Service Provider**는 Use Case 에 종속되어, Use Case 에 정의된 인터페이스를 구현한 구현체입니다.
	- Service Provider에 변경이 생겨도 다른 레이어와 인터페이스를 통해 연결됐기 때문에, 다른 레이어에 영향을 미치지 않습니다.
- **User Interface Adapter**는 사용자로부터 들어오는 입력 또는 이벤트를 상위 레이어인 Use Case로 전달하거나, 이로부터 내려오는 결과를 사용자에게 표시하는 역할을 합니다.
	- User Interface Adapter에서는 주로 MVVM 패턴을 사용했습니다.
		- View와 ViewController를 묶어 View를 구성하고
		- View 마다 ViewModel를 구성했습니다.
		- View와 ViewModel 사이를 간단한 Combine 프레임워크를 사용해 반응형으로 동작할 수 있도록 구성했습니다.
---

개선점

- 받아 온 이미지들에 대한 캐시를 구현하지 않았습니다.
	- 간단하게는 딕셔너리로 캐시를 할 수 있습니다.
		- 하지만 스크롤 형식의 레이아웃을 고려하여, 딕셔너리는 쓰레드에 안전하지 않기 때문에 별도의 쓰레드에 안전한 딕셔너리를 구현 또는 외부 라이브러리를 사용해야 할 것 같습니다.
- 저장된 검색어를 보여주는 UICollectionViewCell의 레이아웃이 특정 텍스트에 대해 잘리는 현상이 발생합니다.
- 사용자에게 제공되는 정보 또는 기능의 양이 충분하지 않습니다.
- 리팩토링을 하지 않았습니다.

---

