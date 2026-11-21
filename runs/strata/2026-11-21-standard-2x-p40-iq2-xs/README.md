# Community benchmark on 2x Tesla P40 24GB

Measured 2026-11-21T05:54:10Z. Protocol `strata-qwen38-thinking-v1-draft.1` (draft), status **complete**.

## Hardware and software

- GPU 0/1: Tesla P40, 24 GiB dedicated VRAM each, 250 W power limit each, ECC disabled.
- PCIe 3.0 x8 per GPU under benchmark load, separate CPU root ports, topology PHB. Engine host-to-device probe: 6.5 GB/s per GPU.
- CPU: AMD Ryzen 5 7600, 6 cores / 12 threads, AVX-512. Engine pool: 5 workers on CPUs 1–5; host thread on CPU 0.
- RAM: 64 GiB installed, 61.98 GiB OS-visible; 4x16 GiB DDR5 at 4000 MT/s.
- Model storage: ADATA LEGEND 960 2TB NVMe SSD, PCIe 4.0 x4, Btrfs.
- OS: Debian GNU/Linux 13.7; kernel 6.12.113+deb13-amd64; NVIDIA driver 580.196.07.
- Strata CLI: 0.2.17, commit `3142b66b96e9c0e775e30f620b11b191a1427c2a`; official engine 0.1.63, build `01d81206d420+cuda12.9`, CUDA 12.9.
- Background work: dcgm-exporter, node-exporter, Codex session.

## Model and configuration

- Model: [ISTA-DASLab/Qwen3.8-Flash-Next-GSQ-RCO-GGUF](https://huggingface.co/ISTA-DASLab/Qwen3.8-Flash-Next-GSQ-RCO-GGUF), IQ2_XS.
- Quantization / embedded tokenizer revision: `ed59f92082b1e93c0e96d60a8b11aab089b52f09`. Original-weight revision: not recorded.
- GGUF SHA-256 values: [results.json](results.json). Both shards, the expert profile and chat template have the same hashes as the V100 run.
- Track: default. Context 32,768; capacity 1; int8 KV; automatic expert cache and prefill; MTP `--spec 4`; vision off; tuning skipped.
- Layer split: GPU 0 layers 0–23, GPU 1 layers 24–47. Expert cache: 12,288 slots per GPU, 16.19 / 16.83 GiB. Automatic prompt chunk: 8,192 tokens.
- Sampling: thinking on, preserve_thinking true, xhigh; temperature 1.0, top_p 0.95, top_k 20, min_p 0, presence penalty 0, repetition penalty 1.
- Effective settings: [config.json](config.json). Template: [chat_template.jinja](provenance/chat_template.jinja).

## Method

- Command: `strata bench run --profile launch-benchmark-p40-iq2xs --suite standard-v1`; full command in [results.json](results.json).
- Launch: `strata launch --family qwen --model IQ2_XS --model-path "$HOME/models/IQ2_XS" --data-dir "$HOME/models" --gpu 0,1 --context 32k --kv int8 --parallel 1 --vision off --drafting mtp --tune skip --port 8081 --save-preset benchmark-p40-iq2xs --yes --no-tui`.
- Newly loaded engine; 0 prior requests; loopback HTTP streaming. One warm-up, 9 performance requests, 12 sanity checks; no retries.
- Performance: 3 repetitions per case, 512 output-token cap including reasoning. Sanity: 2,048-token cap. Optional concurrency not run.
- Prompt and decode rates: engine timings. TTFT and total latency: client timings. Expert/conversation caches retained within the run.
- Required duration: 323.560 s, including warm-up; model loading and hashing excluded.

## Results

Median (minimum–maximum), 3 samples per case. First-answer latency uses only requests with answer text or a tool call.

| Case | Input tokens | Prompt tok/s | Decode tok/s | TTFT s | First answer s | Total s | Capped |
| --- | ---: | --- | --- | --- | --- | --- | --- |
| short | 77/77/77 | n/a | 51.4 (47.6–52.1) | 0.701 (0.670–0.714) | 3.314 (3.006–4.911) n=3 | 7.055 (5.658–8.174) | 0/3 |
| prompt-4k | 4093/4093/4093 | 375.7 (374.5–375.9) | 46.5 (46.2–51.8) | 10.926 (10.920–10.963) | 16.267 (16.267–16.267) n=1 | 21.909 (20.778–22.020) | 3/3 |
| prompt-16k | 16387/16387/16387 | 554.4 (547.2–558.5) | 43.8 (43.5–45.5) | 29.595 (29.374–29.984) | 40.607 (40.330–40.883) n=2 | 41.210 (41.034–41.351) | 3/3 |

- Short input: 77 tokens; its prompt throughput is omitted from the table.
- Capped: requests ending at 512 output tokens. Performance requests: 3 completed, 6 truncated, 0 failed, 0 skipped.
- Warm-up: 1 truncated. Sanity: **12/12 passed** — instruction 4/4, retrieval 4/4, tool calls 4/4; 0 truncated, 0 failed, 0 skipped.
- Protocol model-card revision and original-weight revision are unrecorded; fields are null in results.json.

## Evidence

- [Results](results.json), [request outputs and timings](outputs.jsonl), [engine log](engine.log).
- [Unedited runner JSON](provenance/runner-results.json). Storage and CUDA metadata updates: `extensions.metadata_updates`.
- [Engine manifest](provenance/engine-component.json), [build metadata](provenance/BUILD.json), [hardware snapshot](provenance/hardware-snapshot.json).
- Same-host V100 result: [2x V100 SXM2 16GB](../2026-11-21-standard-2x-v100-sxm2-iq2-xs/README.md).
- Same-host RTX result: [RTX 4070 Ti SUPER](../2026-11-21-standard-rtx-4070-ti-super-iq2-xs/README.md).
