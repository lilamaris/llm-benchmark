# GeForce RTX 4070 Ti SUPER 사양 및 연결 구성

확인일: 2026년 11월 21일 13:51 KST

## 장착 구성

| 항목 | 확인값 |
| --- | --- |
| GPU | NVIDIA GeForce RTX 4070 Ti SUPER × 1 |
| GPU 아키텍처 | Ada Lovelace |
| GPU 칩 식별 | AD103, lspci 보고값 |
| CUDA Compute Capability | 8.9 |
| 버스 | PCIe |
| PCI 주소 | 0000:01:00.0 |
| PCI Vendor / Device ID | 10de:2705 |
| PCI Subsystem Vendor / Device ID | 10de:18ce |
| PCI Revision | a1 |

## OS에서 확인한 PCIe 경로

```text
CPU Root Port 0000:00:01.1
└── RTX 4070 Ti SUPER 0000:01:00.0
```

| 구간 또는 장치 | 확인 시점 링크 | 보고 최대 링크 |
| --- | --- | --- |
| CPU Root Port 0000:00:01.1 | 2.5 GT/s ×16 | 16.0 GT/s ×16 |
| RTX 4070 Ti SUPER 0000:01:00.0 | 2.5 GT/s ×16 | 16.0 GT/s ×16 |

2.5 GT/s는 PCIe 1.0, 16.0 GT/s는 PCIe 4.0이다. 링크 값은 확인 시점의 sysfs 보고값이다. NVIDIA-SMI도 현재 Gen 1 ×16, 최대 Gen 4 ×16을 보고했다. 열거된 경로에서 GPU와 CPU Root Port 사이에 PCIe 스위치는 없다.

## NVIDIA 정보

| 항목 | 확인값 |
| --- | --- |
| 커널 모듈 버전 | 580.196.07 |
| GPU 드라이버 바인딩 | nvidia |
| NVIDIA-SMI 및 드라이버 버전 | 580.196.07 |
| GSP 펌웨어 버전 | 580.196.07 |
| GPU VBIOS | 95.03.45.00.E5 |
| VRAM | 16,376 MiB, NVIDIA-SMI FB Memory Total |
| BAR1 크기 | 16,384 MiB |
| 현재 전력 제한 | 285 W |
| 기본 전력 제한 | 285 W |
| 설정 가능한 전력 제한 범위 | 100–320 W |
| Persistence Mode | Enabled |
| Compute Mode | Default |
| Display Attached / Active | No / Disabled |
| ECC Mode | N/A |
| MIG Mode | N/A |
| CPU 및 NUMA affinity | CPU 0–11, NUMA 0, NVIDIA-SMI topo 보고값 |

NVIDIA-SMI 헤더의 CUDA Version은 13.0이다. 이는 드라이버가 지원하는 CUDA 버전이며, 설치된 Toolkit 또는 strata의 CUDA 런타임 버전을 뜻하지 않는다.

## 확인 시점의 동작 상태

| 항목 | 확인값 |
| --- | --- |
| Performance State | P8 |
| GPU 사용률 | 0% |
| GPU 온도 | 33 °C |
| 팬 속도 | 0% |
| VRAM 사용량 | 15,528 MiB |
| strata 프로세스 VRAM 사용량 | 15,448 MiB |

동작 상태는 수집 시점의 NVIDIA-SMI 출력값이다.

## 수집 원본

[수집 디렉터리](evidence/rtx-4070-ti-super-2026-11-21/)에 PCIe 트리, GPU PCI 정보, sysfs 링크 정보, NVIDIA 커널 정보, NVIDIA-SMI 전체·상세·쿼리·토폴로지·NVLink 출력을 보관한다. `collection.txt`와 `nvidia-collection.txt`에 수집 시각, 명령 및 종료 코드를 기록했다.
