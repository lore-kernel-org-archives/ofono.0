Content-Type: multipart/mixed; boundary="===============1604712249064318612=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v3 0/6] hfp_hf_bluez5: Register Audio Cards in handsfree
 manager
Date: Thu, 28 Feb 2013 10:11:51 -0600
Message-ID: <512F81C7.8060400@gmail.com>
In-Reply-To: <1362067225-8567-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1604712249064318612==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Claudio,

On 02/28/2013 10:00 AM, Claudio Takahasi wrote:
> This patch series contains the changes in the hfp_hf_bluez5 plugin to
> create/register/remove audio cards.
>
> Changes between v0-v1:
> * Removed commit "Switch argument order when creating card"
>
> Changes between v1-v2:
> * Fixed coding style: 80 character limit
>
> Changes between v2-v3:
> * Fixed M5: Git commit message 50/72 formatting
> * Fixed M1: Blank line before and after an if/while/do/for statement
>
> Claudio Takahasi (6):
>    hfp_hf_bluez5: Add registering Audio Card
>    hfp_hf_bluez5: Add local address to Audio Card
>    hfp_hf_bluez5: Remove Card when SLC fails
>    hfp_hf_bluez5: Remove Card if SLC is disconnected
>    hfp_hf_bluez5: Remove Card when modem is disabled
>    hfp_hf_bluez5: Remove Card on RequestDisconnection
>
>   plugins/hfp_hf_bluez5.c | 46 ++++++++++++++++++++++++++++++++++++++++++=
++++
>   1 file changed, 46 insertions(+)
>

All patches in this series have been applied, thanks.

Regards,
-Denis

--===============1604712249064318612==--

