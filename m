Content-Type: multipart/mixed; boundary="===============1157162238958061724=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] hfp_ag_bluez5: use none prefix for AT+BCC.
Date: Tue, 24 Mar 2015 09:12:45 -0500
Message-ID: <551170DD.3080708@gmail.com>
In-Reply-To: <1427206840-5297-1-git-send-email-kubax.t.pawlak@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1157162238958061724==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kuba,

On 03/24/2015 09:20 AM, Kuba Pawlak wrote:
> iPhone 5s with iOS8.2 sometimes failes to acknowledge AT+BCC
> with OK. This means +CIEV events get consumed by this command
> and call ended notification is not parsed.
>
> Nov 30 00:00:19 ofonod[938]: > AT+BCC\r
> Nov 30 00:00:28 ofonod[938]: < \r\n+CIEV: 2,0\r\n
> ---
>   plugins/hfp_hf_bluez5.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>

Patch has been applied, thanks.

Regards,
-Denis


--===============1157162238958061724==--

