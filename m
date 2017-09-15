Content-Type: multipart/mixed; boundary="===============9141090976466313544=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] huawei: add LTE support
Date: Thu, 14 Sep 2017 20:10:31 -0500
Message-ID: <df57c3eb-b7bc-13dd-5108-70c8daea9efd@gmail.com>
In-Reply-To: <1505377117-15001-2-git-send-email-c.ronco@kerlink.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9141090976466313544==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Christophe,

On 09/14/2017 03:18 AM, Christophe Ronco wrote:
> Huawei LTE modems use AT^SYSCFGEX and AT^SYSINFOEX instead of
> AT^SYSCFG and AT^SYSINFO.
> If we want to be able to attach on LTE with this modem, we must use
> AT^SYSCFGEX to configure rat mode and band. Using AT^SYSCFG, mode any
> means UMTS or GSM.
> ---
>   drivers/huaweimodem/radio-settings.c | 209 ++++++++++++++++++++++++++++=
++++---
>   1 file changed, 192 insertions(+), 17 deletions(-)
> =


Applied, thanks.

Regards,
-Denis


--===============9141090976466313544==--

