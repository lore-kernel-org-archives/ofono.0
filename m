Content-Type: multipart/mixed; boundary="===============0225708172563356054=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v0 1/2] hfp_hf_bluez5: Fix registering modem on
 NewConnection
Date: Thu, 31 Jan 2013 16:04:15 -0600
Message-ID: <510AEA5F.8010002@gmail.com>
In-Reply-To: <1359658914-24892-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0225708172563356054==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Claudio,

On 01/31/2013 01:01 PM, Claudio Takahasi wrote:
> HFP modem will be registered when Proxy Added callback gets called
> or when Pair is True. This patch removes the support for dynamic modem
> registration when a new connection is notified and there isn't a modem
> associated with the Bluetooth remote device.
>
> BlueZ behaviour has been changed and a NewConnection is not notified
> before the service discovery finishes.
> ---
>   plugins/hfp_hf_bluez5.c | 23 +++--------------------
>   1 file changed, 3 insertions(+), 20 deletions(-)
>

Patch has been applied, thanks.

Regards,
-Denis


--===============0225708172563356054==--

