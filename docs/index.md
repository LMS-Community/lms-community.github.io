---
hide:
  - navigation
  - toc
layout: default
title: Home
---

<style>
.md-content {
  max-width: 900px;
  margin-left: auto;
  margin-right: auto;
}
</style>

# Lyrion Music Server
<p style="margin-top: -1.5rem; font-size: 1.1rem; color: gray;">Free your music.</p>


<figure markdown="span">
  ![](assets/lyrion-material-screenshot.png){ width="800" }
</figure>

## :material-music: What is Lyrion?

**Lyrion Music Server**, formerly known as Logitech Media Server (LMS) or SlimServer, is a mature, community-driven, open-source audio streaming platform. It acts as a central hub for your music, allowing you to stream your personal local music collection (MP3, FLAC, ALAC, DSD, etc.) alongside major internet streaming services to any room in your house.

Unlike many modern alternatives, Lyrion is completely independent of any single hardware brand or cloud service. It is designed to be lightweight enough to run on a low-power Raspberry Pi, yet powerful enough to manage libraries containing hundreds of thousands of tracks on high-end servers or NAS devices.

## :material-star-shooting: Why Choose Lyrion?

Lyrion is the premier choice for music enthusiasts who value control and longevity. While commercial systems often lock you into specific hardware or monthly fees, Lyrion offers:

<div class="grid cards" markdown>

-   :material-clock-fast:{ .lg .middle } __Lyrion runs everywhere__

    ---

    It runs on almost anything, from a vintage laptop to a high-end NAS, Raspberry Pi, or Docker container.

    [:octicons-arrow-right-24: Getting started](getting-started)

-   :material-human-greeting-variant:{ .lg .middle } __Community powered__

    ---

    Being open-source means the system is built by people who actually use it. On our forums you will find a welcoming community.

    [:octicons-arrow-right-24: Forums](https://forums.lyrion.org/)
    
-   :material-home-heart:{ .lg .middle } __True ownership__

    ---

    Your data and library remain yours. No mandatory cloud accounts, tracking, or unexpected subscription hikes.

-   :material-rocket-launch:{ .lg .middle } __Future-Proof__

    ---

    You are never at the mercy of a single company's financial decisions or discontinued product lines.

-   :material-puzzle:{ .lg .middle } __Extremely extensible__

    ---

    There are [plugins](plugins) and [extensions](extensions/applications) created for every use case imaginable.

    [:octicons-arrow-right-24: Plugins](plugins/directory)

-   :material-scale-balance:{ .lg .middle } __Open Source__

    ---

    For over 25 years has Lyrion been open-source! The sourcecode is available on [GitHub](https://github.com/LMS-Community).

    [:octicons-arrow-right-24: License](https://github.com/LMS-Community/slimserver?tab=License-1-ov-file)

</div>

## :material-rocket-launch: Lyrion philosophy

Based on the Lyrion philosophy, the system is built on these four pillars:

1.  **Free Software:** Completely open-source and free to use forever.
2.  **Hardware Agnostic:** Use your existing audio gear, AirPlay receivers, Chromecasts, or DIY players (like Squeezelite).
3.  **Massive Scalability:** Effortlessly handles libraries with 100,000+ tracks with lightning-fast indexing and search.
4.  **Perfect Multi-room:** Achieve sample-accurate synchronization across your entire home, regardless of the different hardware brands you use.

## :material-compare: How does it stack up?

| Feature                            | [Lyrion](https://lyrion.org)                                                                | [Roon](https://roonlabs.com)                                            | [Plexamp](https://plex.tv)                                            | [Sonos](https://sonos.com)                                           | [moOde audio](https://moodeaudio.org) | [Volumio](https://volumio.com)                                               |
| ---------------------------------- | ------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------- | --------------------------------------------------------------------- | -------------------------------------------------------------------- | ------------------------------------- | --------------------------------------------------------- |
| **License**                        | ✅ Open-source                                                                               | ❌ Proprietary                                                           | ❌ Proprietary                                                         | ❌ Proprietary                                                        | ✅ Open-source                         | ✅ Open-source                                             |
| **Pricing model**                  | ✅ Free                                                                                      | ❌ 12.49/mo (annual) or 14.99/mo (monthly)                               | 🟡 Free tier; Plex Pass: 4.99/mo,39.99/yr, or $249.99 lifetime (2025) | ❌ Hardware purchase (179−999+ per speaker); no subscription required | ✅ Free                                | 🟡 Free tier; Premium plugins available                   |
| **Platform/Installation**          | ✅ Self-hosted (Linux, Windows, macOS, Docker)                                               | ✅ Roon Core on PC/Mac/Nucleus hardware                                  | ✅ Requires Plex Media Server                                          | ❌ Proprietary hardware ecosystem                                     | ✅ Raspberry Pi focused                | ✅ Raspberry Pi focused                                    |
| **Multi-room Audio**               | ✅ Native, with transcoding if needed                                                        | ✅ Native                                                                | ✅ Multi-room sync with Plex Pass                                      | ✅ Native                                                             | 🟡 Only with Snapcast plugin          | 🟡 Only with Snapcast plugin                              |
| **Hi-Res**                         | ✅ Native bit-perfect handling of 192kHz/24bit and up and DSD-support (using plugin)         | ✅ Bit-perfect and support for DSD and MQA                               | 🟡 Supported                                                          | 🟡 Limited                                                           | ✅ Bit-perfect and support for DSD     | ✅ Bit-perfect up to 384kHz/32-bit and native DSD over I2S |
| **Gapless Playback**               | ✅ Yes                                                                                       | ✅ Yes                                                                   | ✅ Yes                                                                 | 🟡 Yes (hardware-dependent)                                          | ✅ Yes                                 | ✅ Yes                                                     |
| **Plugin/Extension Support**       | ✅ Extensive plugin ecosystem                                                                | 🟡 Limited (closed ecosystem)                                           | 🟡 Limited (Plex ecosystem)                                           | 🟡 Limited (closed ecosystem)                                        | 🟡 Moderate plugin system available   | 🟡 Marketplace with free/paid plugins                     |
| **Cloud dependency**               | ✅ No cloud dependency                                                                       | 🟡 Requires Cloud                                                       | ✅ Offline mode is supported                                           | 🟡 Limited offline functionality                                     | ✅ No cloud dependency                 | ✅ No cloud dependency                                     |
| **Remote Access**                  | 🟡 Yes, using a VPN                                                                         | ✅ Built-in remote access                                                | 🟡 Requires Plex Pass (since 2025)                                    | 🟡 Built-in (cloud-dependent)                                        | ✅ Via plugins/config                  | ✅ Via plugins/config                                      |
| **Metadata Handling**              | ✅ Advanced and classical work support                                                       | ✅ Industry Leader with deep metadata enrichment (bios, lyrics, reviews) | 🟡 Auto-tagging, "Play More Like This"                                | 🟡 Basic metadata                                                    | ✅ Plugin-based enrichment             | ✅ Plugin-based enrichment                                 |
| **Streaming Services Integration** | ✅ Full library integration with plugins for Qobuz, Tidal, Spotify, Deezer, SoundCloud, etc. | ✅ Native integration with major services                                | ✅ Integrated with Plex library                                        | ✅ Native Spotify, Apple Music, Tidal, etc.                           | 🟡 Spotify Connect via plugin         | ✅ Built-in Spotify, Tidal, Qobuz plugins                  |
| **Ease of Use**                    | 🟡 Moderate                                                                                 | ✅ Very High                                                             | ✅ High                                                                | ✅ Very High                                                          | 🟡 Moderate                           | 🟡 Moderate                                               |
| Community Support                  | ✅ Active forums, GitHub                                                                     | ✅ Official support + forums                                             | ✅ Official support + forums                                           | ✅ Official support + forums                                          | ✅ Active community + paid support     | ✅ Active audiophile community                             |


## :material-briefcase: Recommendations by Use Case

| User Profile | Recommended Solution | Why |
| :--- | :--- | :--- |
| :material-credit-card-check: **Budget-conscious audiophile** | Lyrion or moOde Audio | Free, high-quality audio, self-hosted control
| :material-check: **Convenience-focused user** | Sonos or Roon | Minimal setup, polished experience
| :simple-plex: **Existing Plex user** | Plexamp | Leverages existing infrastructure, cost-effective
| :material-violin: **Classical music enthusiast** | Lyrion or Roon | Superior metadata handling for classical works
| :material-incognito: **Privacy-focused user** | Lyrion, moOde or Volumio | Self-hosted, no cloud dependency
| :material-home: **Multi-room household** | Lyrion or Sonos | Excellent synchronization capabilities
| :simple-raspberrypi: **Raspberry Pi builder** | Lyrion, Volumio or MoOde  | Optimized for Pi hardware
| :material-open-source-initiative: **Open-source advocate** | Lyrion, Volumio or MoOde | Fully open-source, community-driven



## :material-details: Detailed Feature Analysis

### 1. The Power of Plugins
Lyrion’s greatest asset is its community repository. Lyrion allows you to "bolt on" features to suit your specific needs:

*   **Material Skin:** A modern, responsive web interface that transforms the look into a sleek, contemporary app experience.
*   **Spotty:** Arguably the most robust Spotify integration for any music server, allowing full library integration.
*   **Music and Artist Information:** Automatically pulls biographies, lyrics, and high-quality artwork from multiple web sources.
*   **Bridge Plugins:** Use the UPnP/DLNA, Chromecast, and AirPlay bridges to turn almost any smart speaker into a Lyrion player.
*   **DSD support:** Supports DSD64, DSD128, and DSD256. Through the **DSDPlayer plugin**, it handles `.dsf` and `.dff` files. It offers "Native DSD" for supported DACs on Linux/Windows and "DoP" (DSD over PCM) for macOS and hardware-limited bridges. Also, it can transcode DSD streams to players that don't natively support them.

### 2. Interfaces and Customization
Lyrion isn't locked into a single "look." Users can choose their experience:

*   **Classic Web UI:** Lightweight and functional for older hardware.
*   **Material Skin:** The gold standard for modern browsers and mobile devices.
*   **JiveLite:** A specialized interface for local displays, perfect for Raspberry Pi touchscreens.

### 3. Metadata and Library Management
Lyrion is famous for its ability to handle complex libraries where others fail.

*   **Classical Music Support:** Proper handling of "Works," "Conductors," and "Composers."
*   **Box Set Management:** Intelligent grouping of multi-disc sets.
*   **On-the-fly Transcoding:** The server can downsample hi-res files in real-time for older devices while maintaining the original quality for your main Hi-Fi system.


## :octicons-move-to-end-24: Getting started

Convinced and want to try it out? Click on [Getting Started with LMS](getting-started/index.md) to learn more.
