# Strata IQ2_XS 표준 벤치마크 결과

측정일: 2026년 11월 21일. [공통 호스트 사양](../../docs/host-specs.md).

- 모델: ISTA-DASLab/Qwen3.8-Flash-Next-GSQ-RCO-GGUF, IQ2_XS, 리비전 `ed59f92082b1e93c0e96d60a8b11aab089b52f09`.
- Strata CLI 0.2.17, 엔진 0.1.63, NVIDIA 드라이버 580.196.07.
- 프로토콜: `strata-qwen38-thinking-v1-draft.1`, 초안. 컨텍스트 32,768, int8 KV, 동시 요청 1개, MTP spec 4, thinking xhigh.
- 입력 4,093 / 16,387토큰, 성능 요청 출력 상한 512토큰. 처리량 단위 tok/s, 각 3회 중앙값.

| GPU 구성 | CUDA | 4K Prompt / Decode | 16K Prompt / Decode | 정합성 검사 | 결과 |
| --- | --- | ---: | ---: | --- | --- |
| V100 SXM2 16GB ×2 | 12.9 | 1,338.2 / 81.3 | 2,048.6 / 80.8 | 12/12 | [complete](2026-11-21-standard-2x-v100-sxm2-iq2-xs/README.md) |
| RTX 4070 Ti SUPER | 13.0 | 2,806.7 / 93.1 | 3,497.0 / 92.4 | 12/12 | [complete](2026-11-21-standard-rtx-4070-ti-super-iq2-xs/README.md) |
| P40 24GB ×2 | 12.9 | 375.7 / 46.5 | 554.4 / 43.8 | 12/12 | [complete](2026-11-21-standard-2x-p40-iq2-xs/README.md) |

각 결과 폴더에 실행 설정, 요청별 JSON, 생성 출력, 엔진 로그와 해시를 저장했다.
