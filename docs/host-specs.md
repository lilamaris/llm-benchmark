# 공통 호스트 사양

확인일: 2026년 11월 21일 KST

## OS와 펌웨어

| 항목 | 값 |
| --- | --- |
| 배포판 | Debian GNU/Linux 13.7 trixie |
| 커널 | Linux 6.12.113+deb13-amd64 |
| 커널 패키지 버전 | Debian 6.12.113-1 |
| 아키텍처 | x86_64 |
| 메인보드 | ASUSTeK ProArt B650-CREATOR Rev 1.xx |
| BIOS | American Megatrends Inc. 3513 |
| BIOS 날짜 | 2026-01-28 |

## 메인보드 확장 슬롯

Ryzen 5 7600 구성의 슬롯 사양:

| 연결 | 슬롯 | 전기적 레인 구성 |
| --- | --- | --- |
| CPU | PCIe 4.0, 물리 x16 슬롯 2개 | 단독 x16 또는 동시 x8/x8 |
| B650 칩셋 | PCIe 4.0, 물리 x16 슬롯 1개 | 최대 x4, M.2_3와 대역폭 공유 |
| B650 칩셋 | PCIe 4.0 x1 슬롯 1개 | x1 |

CPU 연결 슬롯 두 개의 동시 구성은 x8/x8이다. [ASUS 공식 사양](https://www.asus.com/us/motherboards-components/motherboards/proart/proart-b650-creator/techspec/)

## CPU

| 항목 | 값 |
| --- | --- |
| 모델 | AMD Ryzen 5 7600 6-Core Processor |
| 소켓 수 | 1 |
| 물리 코어 수 | 6 |
| 논리 CPU 수 | 12 |
| 코어당 스레드 | 2 |
| 온라인 CPU | 0–11 |
| NUMA | 1개 노드, CPU 0–11 |
| L1 데이터 캐시 | 합계 192 KiB, 6개 |
| L1 명령어 캐시 | 합계 192 KiB, 6개 |
| L2 캐시 | 합계 6 MiB, 6개 |
| L3 캐시 | 32 MiB, 1개 |
| AVX 및 AVX2 | 지원, OS 노출 플래그 확인 |
| AVX-512 | 지원, OS 노출 플래그 확인 |
| 마이크로코드 | 0xa60120c |

확인된 AVX-512 플래그:

```text
avx512f avx512dq avx512ifma avx512cd avx512bw avx512vl
avx512_bf16 avx512vbmi avx512_vbmi2 avx512_vnni
avx512_bitalg avx512_vpopcntdq
```

## RAM

| 항목 | 값 |
| --- | --- |
| 장착 용량 | 64 GiB, 16 GiB × 4개 |
| OS 인식 용량 | 66,546,540,544 bytes, 약 61.98 GiB |
| 종류 | DDR5 DIMM, Unbuffered Unregistered |
| 제조사 | Crucial Technology |
| 모듈 명목 속도 | 5600 MT/s |
| 현재 설정 속도 | 모든 모듈 4000 MT/s, 펌웨어 Configured Speed 기준 |
| 채널별 장착 | Channel A 2개, Channel B 2개 |
| 랭크 | 모듈당 1 |
| 데이터 폭 및 전체 폭 | 모듈당 64 bit / 64 bit |

| 채널 | 슬롯 표기 | 용량 | 부품 번호 | 명목 속도 | 현재 설정 속도 |
| --- | --- | --- | --- | --- | --- |
| P0 CHANNEL A | DIMM 0 | 16 GiB | CT16G56C46U5.M8D1 | 5600 MT/s | 4000 MT/s |
| P0 CHANNEL A | DIMM 1 | 16 GiB | CT16G56C46U5.M8G1 | 5600 MT/s | 4000 MT/s |
| P0 CHANNEL B | DIMM 0 | 16 GiB | CT16G56C46U5.M8D1 | 5600 MT/s | 4000 MT/s |
| P0 CHANNEL B | DIMM 1 | 16 GiB | CT16G56C46U5.M8G1 | 5600 MT/s | 4000 MT/s |

현재 설정 속도는 펌웨어의 Configured Speed 보고값이다. 단위는 MT/s다.

## 저장장치

| 항목 | 값 |
| --- | --- |
| 종류 | NVMe SSD |
| 모델 | ADATA LEGEND 960 |
| 용량 | 2 TB급, 2,048,408,248,320 bytes |
| 버스 | PCIe |
| 폼팩터 | M.2 2280, 제품 박스 표기 |
| 최대 링크 | PCIe 4.0 ×4, 16.0 GT/s |
| 현재 링크 | PCIe 4.0 ×4, 16.0 GT/s |
| 펌웨어 | A230W3UA |
| PCI 주소 | 0000:06:00.0 |
| 장치 | nvme0n1 |

## 확인 시점의 시스템 설정

| 항목 | 값 |
| --- | --- |
| CPU 주파수 드라이버 | amd-pstate-epp |
| CPU0 governor | powersave |
| CPU0 energy performance preference | performance |
| CPU0 보고 주파수 범위 | 545–5170 MHz |
| CPU boost | 활성화 |
| Transparent Huge Pages | always |
| Swap 총용량 | 13,309,304,832 bytes, 약 12.40 GiB |

## 사양 확인 경로

| 항목 | 확인 경로 |
| --- | --- |
| OS 및 커널 | /etc/os-release, uname, /proc/version |
| CPU 토폴로지 및 명령어 플래그 | lscpu, /proc/cpuinfo |
| 메인보드 및 BIOS | /sys/devices/virtual/dmi/id/ |
| RAM 모듈 및 설정 속도 | /run/udev/data/+dmi:id의 MEMORY_DEVICE 항목 |
| SSD 모델 및 펌웨어 | /sys/class/nvme/nvme0/ |
| SSD 용량 | /sys/class/block/nvme0n1/size, 512 byte 섹터 단위 |
| SSD PCIe 링크 | /sys/bus/pci/devices/0000:06:00.0/의 current_link 및 max_link 항목 |
| OS 인식 RAM 및 swap | /proc/meminfo, free -b |
| 주파수 정책 및 boost | /sys/devices/system/cpu/cpu0/cpufreq/, /sys/devices/system/cpu/cpufreq/boost |
| Transparent Huge Pages | /sys/kernel/mm/transparent_hugepage/enabled |
