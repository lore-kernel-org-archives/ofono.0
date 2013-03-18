Content-Type: multipart/mixed; boundary="===============8250989549800446800=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v0 01/15] handsfree-audio: Add card driver
Date: Mon, 18 Mar 2013 13:58:02 -0500
Message-ID: <514763BA.5090300@gmail.com>
In-Reply-To: <1363092133-1092-2-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8250989549800446800==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Claudio,

On 03/12/2013 07:41 AM, Claudio Takahasi wrote:
> This patch adds a new handsfree audio driver abstration to allow
> implementing the connect callbacks and other potential functions
> specific of each HFP profile version. This approach also avoids
> including dependency of hfpmodem in handsfree-audio, keeping the service
> level handling inside the hfp_hf_bluez5 only.
> ---
>   include/handsfree-audio.h | 11 +++++++++++
>   src/handsfree-audio.c     | 34 ++++++++++++++++++++++++++++++++++
>   2 files changed, 45 insertions(+)
>

I pushed my own version of this patch.

Regards,
-Denis

--===============8250989549800446800==--

