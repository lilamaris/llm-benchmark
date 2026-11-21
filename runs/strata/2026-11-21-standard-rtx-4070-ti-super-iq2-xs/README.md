# Community benchmark on NVIDIA GeForce RTX 4070 Ti SUPER

Measured 2026-11-21T04:58:47Z. Protocol `strata-qwen38-thinking-v1-draft.1` (draft), status **complete**.

## Hardware and software

- GPU 0: NVIDIA GeForce RTX 4070 Ti SUPER, 16,376 MiB dedicated VRAM, 285 W power limit, ECC N/A.
- PCIe 4.0 x16 under benchmark load; direct CPU root-port connection; no PCIe switch. Engine host-to-device probe: 26.8 GB/s.
- CPU: AMD Ryzen 5 7600, 6 cores / 12 threads, AVX-512. Engine pool: 5 workers on CPUs 1–5; host thread on CPU 0.
- RAM: 64 GiB installed, 61.98 GiB OS-visible; 4x16 GiB DDR5 at 4000 MT/s.
- Model storage: ADATA LEGEND 960 2TB NVMe SSD, PCIe 4.0 x4, Btrfs.
- OS: Debian GNU/Linux 13.7; kernel 6.12.113+deb13-amd64; NVIDIA driver 580.196.07.
- Strata CLI: 0.2.17, commit `3142b66b96e9c0e775e30f620b11b191a1427c2a`; official engine 0.1.63, build `01d81206d420+cuda13.0`, CUDA 13.0.
- Background work: dcgm-exporter, node-exporter, Codex session.

## Model and configuration

- Model: [ISTA-DASLab/Qwen3.8-Flash-Next-GSQ-RCO-GGUF](https://huggingface.co/ISTA-DASLab/Qwen3.8-Flash-Next-GSQ-RCO-GGUF), IQ2_XS.
- Quantization / embedded tokenizer revision: `ed59f92082b1e93c0e96d60a8b11aab089b52f09`. Original-weight revision: not recorded.
- GGUF SHA-256 values: [results.json](results.json). Both shards, the expert profile and chat template have the same hashes as the V100 run.
- Track: default. Context 32,768; capacity 1; int8 KV; automatic expert cache and prefill; MTP `--spec 4`; vision off; tuning skipped.
- Expert cache: 7,072 slots, 9.47 GiB. Automatic prompt chunk: 18,176 tokens.
- Sampling: thinking on, preserve_thinking true, xhigh; temperature 1.0, top_p 0.95, top_k 20, min_p 0, presence penalty 0, repetition penalty 1.
- Effective settings: [config.json](config.json). Template: [chat_template.jinja](provenance/chat_template.jinja).

## Method

- Command: `strata bench run --profile launch-benchmark-rtx4070-iq2xs --suite standard-v1`; full command in [results.json](results.json).
- Launch: `strata launch --family qwen --model IQ2_XS --model-path "$HOME/models/IQ2_XS" --data-dir "$HOME/models" --gpu 0 --context 32k --kv int8 --parallel 1 --vision off --drafting mtp --tune skip --port 8081 --save-preset benchmark-rtx4070-iq2xs --yes --no-tui`.
- Newly loaded engine; 0 prior requests; loopback HTTP streaming. One warm-up, 9 performance requests, 12 sanity checks; no retries.
- Performance: 3 repetitions per case, 512 output-token cap including reasoning. Sanity: 2,048-token cap. Optional concurrency not run.
- Prompt and decode rates: engine timings. TTFT and total latency: client timings. Expert/conversation caches retained within the run.
- Required duration: 96.067 s, including warm-up; model loading and hashing excluded.

## Results

Median (minimum–maximum), 3 samples per case. First-answer latency uses only requests with answer text or a tool call.

| Case | Input tokens | Prompt tok/s | Decode tok/s | TTFT s | First answer s | Total s | Capped |
| --- | ---: | --- | --- | --- | --- | --- | --- |
| short | 77/77/77 | n/a | 96.1 (90.3–99.9) | 0.513 (0.432–0.556) | 4.189 (1.382–5.054) n=3 | 5.823 (2.871–5.873) | 1/3 |
| prompt-4k | 4093/4093/4093 | 2806.7 (2713.3–2885.6) | 93.1 (90.6–93.7) | 1.477 (1.436–1.526) | 6.327 (6.130–6.524) n=2 | 6.974 (6.922–7.115) | 3/3 |
| prompt-16k | 16387/16387/16387 | 3497.0 (3476.1–3502.7) | 92.4 (90.9–94.9) | 4.710 (4.704–4.742) | 10.012 (10.012–10.012) n=1 | 10.267 (10.091–10.325) | 3/3 |

- Short input: 77 tokens; its prompt throughput is omitted from the table.
- Capped: requests ending at 512 output tokens. Performance requests: 2 completed, 7 truncated, 0 failed, 0 skipped.
- Warm-up: 1 truncated. Sanity: **12/12 passed** — instruction 4/4, retrieval 4/4, tool calls 4/4; 0 truncated, 0 failed, 0 skipped.
- Protocol model-card revision and original-weight revision are unrecorded; fields are null in results.json.

## Evidence

- [Results](results.json), [request outputs and timings](outputs.jsonl), [engine log](engine.log).
- [Unedited runner JSON](provenance/runner-results.json). Storage metadata update: `extensions.metadata_updates`.
- [Engine manifest](provenance/engine-component.json), [build metadata](provenance/BUILD.json), [hardware snapshot](provenance/hardware-snapshot.json).
- Same-host V100 result: [2x V100 SXM2 16GB](../2026-11-21-standard-2x-v100-sxm2-iq2-xs/README.md).
