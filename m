Content-Type: multipart/mixed; boundary="===============3455213585663689725=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/1] huawei: use AT^SYSCFG for radio setting operations on
 3G only modems
Date: Thu, 11 Jun 2020 09:32:16 -0500
Message-ID: <b43d93c2-9e9e-93b9-e614-7cd9d717a456@gmail.com>
In-Reply-To: <1591866746-5233-1-git-send-email-c.ronco@kerlink.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3455213585663689725==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Christophe,

On 6/11/20 4:12 AM, Christophe Ronco wrote:
> AT^SYSCFGEX must be used on LTE Huawei modems to enable LTE support.
> But some modems (or firmwares?) do not support this command and AT^SYSCFG
> must be used to get/set radio settings.
> This has been introduced in commit:
> 22adf6402c828f8b8cca1b65d8a46ba7792eb787
> =

> There is a bug in this commit and AT^SYSCFGEX commands are used even on
> modems not supporting it.
> ---
>   drivers/huaweimodem/radio-settings.c | 1 +
>   1 file changed, 1 insertion(+)
> =


Applied, thanks.

Regards,
-Denis

--===============3455213585663689725==--

