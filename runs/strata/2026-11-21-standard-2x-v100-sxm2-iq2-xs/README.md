# Community benchmark on 2x Tesla V100 SXM2 16GB

Measured 2026-11-21T04:18:52Z. Protocol `strata-qwen38-thinking-v1-draft.1` (draft), status **complete**.

## Hardware and software

- GPU 0/1: Tesla V100-SXM2-16GB, 16 GiB each, 300 W each, ECC enabled.
- AOM-SXMV; PCIe 3.0 x16 per GPU behind one PEX 8764 host uplink at PCIe 3.0 x16; GPU topology NV2.
- CPU: AMD Ryzen 5 7600, 6 cores / 12 threads, AVX-512. Engine pool: 5 workers on CPUs 1–5; host thread on CPU 0.
- RAM: 64 GiB installed, 61.98 GiB OS-visible; 4x16 GiB DDR5 at 4000 MT/s.
- Model storage: ADATA LEGEND 960 2TB NVMe SSD, PCIe 4.0 x4, Btrfs.
- OS: Debian GNU/Linux 13.7; kernel 6.12.113+deb13-amd64; NVIDIA driver 580.196.07.
- Strata CLI: 0.2.17, commit `3142b66b96e9c0e775e30f620b11b191a1427c2a`; official engine 0.1.63, build `01d81206d420+cuda12.9`, CUDA 12.9.
- Background work: dcgm-exporter, node-exporter, Codex session.

## Model and configuration

- Model: [ISTA-DASLab/Qwen3.8-Flash-Next-GSQ-RCO-GGUF](https://huggingface.co/ISTA-DASLab/Qwen3.8-Flash-Next-GSQ-RCO-GGUF), IQ2_XS.
- Quantization / embedded tokenizer revision: `ed59f92082b1e93c0e96d60a8b11aab089b52f09`. Original-weight revision: not recorded.
- GGUF SHA-256 values: [results.json](results.json). Both shards match the repository revision.
- Track: default. Context 32,768; capacity 1; int8 KV; automatic expert cache and prefill; MTP `--spec 4`; vision off; tuning skipped.
- Layer split: GPU 0 layers 0–24, GPU 1 layers 25–47. Expert cache: 9,462 / 8,237 slots.
- Sampling: thinking on, preserve_thinking true, xhigh; temperature 1.0, top_p 0.95, top_k 20, min_p 0, presence penalty 0, repetition penalty 1.
- Effective settings: [config.json](config.json). Template: [chat_template.jinja](provenance/chat_template.jinja).

## Method

- Command: `strata bench run --profile launch-benchmark-v100-iq2xs --suite standard-v1`; full command in [results.json](results.json).
- Launch: `strata launch --family qwen --model IQ2_XS --model-path "$HOME/models/IQ2_XS" --data-dir "$HOME/models" --gpu 0,1 --context 32k --parallel 1 --vision off --drafting mtp --tune skip --port 8081 --save-preset benchmark-v100-iq2xs --yes --no-tui`.
- Newly loaded engine; 0 prior requests; loopback HTTP streaming. One warm-up, 9 performance requests, 12 sanity checks; no retries.
- Performance: 3 repetitions per case, 512 output-token cap including reasoning. Sanity: 2,048-token cap. Optional concurrency not run.
- Prompt and decode rates: engine timings. TTFT and total latency: client timings. Expert/conversation caches retained within the run.
- Required duration: 126.204 s, including warm-up; model loading and hashing excluded.

## Results

Median (minimum–maximum), 3 samples per case. First-answer latency uses only requests with answer text or a tool call.

| Case | Input tokens | Prompt tok/s | Decode tok/s | TTFT s | First answer s | Total s | Capped |
| --- | ---: | --- | --- | --- | --- | --- | --- |
| short | 77/77/77 | n/a | 89.4 (89.2–94.0) | 0.458 (0.439–0.461) | 2.128 (1.238–3.473) n=3 | 3.465 (3.348–6.172) | 1/3 |
| prompt-4k | 4093/4093/4093 | 1338.2 (1319.5–1340.3) | 81.3 (79.3–81.4) | 3.077 (3.073–3.121) | 8.311 (8.311–8.311) n=1 | 9.394 (9.356–9.522) | 3/3 |
| prompt-16k | 16387/16387/16387 | 2048.6 (2026.2–2053.3) | 80.8 (80.4–81.8) | 8.022 (8.004–8.111) | not measured | 14.356 (14.263–14.433) | 3/3 |

- Short input: 77 tokens; its prompt throughput is omitted from the table.
- Capped: requests ending at 512 output tokens. Performance requests: 2 completed, 7 truncated, 0 failed, 0 skipped.
- Warm-up: 1 truncated. Sanity: **12/12 passed** — instruction 4/4, retrieval 4/4, tool calls 4/4; 0 truncated, failed or skipped.
- Protocol model-card revision and original-weight revision are unrecorded; fields are null in results.json.

## Evidence

- [Results](results.json), [request outputs and timings](outputs.jsonl), [engine log](engine.log).
- [Unedited runner JSON](provenance/runner-results.json). Storage and CUDA metadata updates are listed in `extensions.metadata_updates`.
- [Engine manifest](provenance/engine-component.json), [build metadata](provenance/BUILD.json), [hardware snapshot](provenance/hardware-snapshot.json).
- Reference report: [2026-10-05-community-v100-sxm2](https://github.com/Niko1221/Strata/tree/main/docs/bench-results/2026-10-05-community-v100-sxm2). That report used one 32GB V100, Windows, greedy sampling and an 8,000-token prompt; this run uses the current standard protocol.
