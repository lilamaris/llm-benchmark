# Tesla P40 PCIe 사양 및 연결 구성

확인일: 2026년 11월 21일 14:48 KST

## 장착 구성

| 항목 | 확인값 |
| --- | --- |
| GPU | Tesla P40 × 2 |
| GPU 아키텍처 | Pascal |
| GPU 칩 식별 | GP102GL, lspci 보고값 |
| CUDA Compute Capability | 두 GPU 모두 6.1 |
| 버스 | PCIe |
| GPU 0 PCI 주소 | 0000:01:00.0 |
| GPU 1 PCI 주소 | 0000:03:00.0 |
| PCI Vendor / Device ID | 두 GPU 모두 10de:1b38 |
| PCI Subsystem Vendor / Device ID | 두 GPU 모두 10de:11d9 |
| PCI Revision | 두 GPU 모두 a1 |

## OS에서 확인한 PCIe 경로

```text
CPU Root Complex 0000:00
├── CPU Root Port 0000:00:01.1
│   └── P40 GPU 0 0000:01:00.0
└── CPU Root Port 0000:00:01.3
    └── P40 GPU 1 0000:03:00.0
```

| 구간 또는 장치 | 확인 시점 링크 | 보고 최대 링크 |
| --- | --- | --- |
| CPU Root Port 0000:00:01.1 | 2.5 GT/s ×8 | 16.0 GT/s ×8 |
| P40 GPU 0 0000:01:00.0 | 2.5 GT/s ×8 | 8.0 GT/s ×16 |
| CPU Root Port 0000:00:01.3 | 2.5 GT/s ×8 | 16.0 GT/s ×8 |
| P40 GPU 1 0000:03:00.0 | 2.5 GT/s ×8 | 8.0 GT/s ×16 |

2.5 GT/s는 PCIe 1.0, 8.0 GT/s는 PCIe 3.0, 16.0 GT/s는 PCIe 4.0이다. 링크 값은 확인 시점의 sysfs 보고값이다. NVIDIA-SMI도 두 GPU 모두 현재 Gen 1 ×8, GPU 최대 Gen 3 ×16을 보고했다.

각 GPU는 별도의 CPU Root Port에 연결되어 있다. 열거된 GPU 경로에 PCIe 스위치는 없다. 현재 호스트의 Root Port 최대 링크 폭은 각각 ×8이다.

## NVIDIA 정보

| 항목 | 확인값 |
| --- | --- |
| 커널 모듈 버전 | 580.196.07 |
| GPU 드라이버 바인딩 | 두 GPU 모두 nvidia |
| NVIDIA-SMI 및 드라이버 버전 | 580.196.07 |
| GPU VBIOS | 두 GPU 모두 86.02.23.00.00 |
| GPU당 VRAM | 24,576 MiB, NVIDIA-SMI FB Memory Total |
| GPU당 BAR1 크기 | 32,768 MiB |
| GPU당 현재 전력 제한 | 250 W |
| GPU당 기본 전력 제한 | 250 W |
| GPU당 설정 가능한 전력 제한 범위 | 125–250 W |
| Persistence Mode | 두 GPU 모두 Enabled |
| Compute Mode | 두 GPU 모두 Default |
| Display Attached / Active | 두 GPU 모두 No / Disabled |
| ECC Mode | 두 GPU 모두 Current 및 Pending: Disabled |
| MIG Mode | 두 GPU 모두 N/A |
| GPU 간 토폴로지 | GPU 0 ↔ GPU 1: PHB |
| CPU 및 NUMA affinity | 두 GPU 모두 CPU 0–11, NUMA 0, NVIDIA-SMI topo 보고값 |

PHB는 GPU 간 연결 경로가 PCIe 및 PCIe Host Bridge를 통과한다는 NVIDIA-SMI 토폴로지 표기다. 이는 GPU 간 데이터 전송 성능의 실측값이 아니다.

NVIDIA-SMI 헤더의 CUDA Version은 13.0이다. 이는 드라이버가 지원하는 CUDA 버전이며, 설치된 Toolkit 또는 애플리케이션의 CUDA 런타임 버전을 뜻하지 않는다.

## 확인 시점의 동작 상태

| 항목 | GPU 0 | GPU 1 |
| --- | --- | --- |
| Performance State | P8 | P8 |
| GPU 사용률 | 0% | 0% |
| GPU 온도 | 45 °C | 48 °C |
| 팬 속도 보고값 | N/A | N/A |
| VRAM 사용량 | 0 MiB | 0 MiB |

수집 시점의 NVIDIA-SMI 출력에는 실행 중인 GPU 프로세스가 없었다. 동작 상태는 `nvidia-smi.txt` 수집 시점의 값이다.

## 수집 원본

[수집 디렉터리](evidence/p40-pcie-2026-11-21/)에 PCIe 트리, 장치 및 드라이버 정보, sysfs 링크 정보, NVIDIA 커널 정보, NVIDIA-SMI 전체·상세·쿼리·토폴로지·NVLink 출력을 보관한다. `collection.txt`와 `nvidia-collection.txt`에 수집 시각, 명령 및 종료 코드를 기록했다.
