Content-Type: multipart/mixed; boundary="===============6148678588348158438=="
MIME-Version: 1.0
From: Kalle Valo <kalle.valo@canonical.com>
Subject: Re: huawei e1550
Date: Wed, 13 Oct 2010 15:51:55 +0300
Message-ID: <87tykqcl1w.fsf@potku.valot.fi>
In-Reply-To: <1286973748.10204.5.camel@mezon.ru>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6148678588348158438==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Alexander A Khryukin <alexander@mezon.ru> writes:

> # patch -p1 < ofono.patch =

>
> patching file plugins/huawei.c
> Hunk #1 FAILED at 624.
> 1 out of 1 hunk FAILED -- saving rejects to file plugins/huawei.c.rej
>
> im using
> http://www.kernel.org/pub/linux/network/ofono/ofono-0.31.tar.bz2

My patch was against latest git. But I copy pasted the patch, maybe that
was the reason it failed. Here's a new one, this time against 0.31.

diff --git a/plugins/huawei.c b/plugins/huawei.c
index 12abdc6..3372454 100644
--- a/plugins/huawei.c
+++ b/plugins/huawei.c
@@ -617,8 +617,6 @@ static void huawei_post_online(struct ofono_modem *mode=
m)
 								data->pcui);
 =

 	ofono_sms_create(modem, OFONO_VENDOR_HUAWEI, "atmodem", data->pcui);
-	ofono_cbs_create(modem, OFONO_VENDOR_QUALCOMM_MSM,
-						"atmodem", data->pcui);
 	ofono_ussd_create(modem, OFONO_VENDOR_QUALCOMM_MSM,
 						"atmodem", data->pcui);
=20

--===============6148678588348158438==--

