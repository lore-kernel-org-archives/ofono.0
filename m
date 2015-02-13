Content-Type: multipart/mixed; boundary="===============1325039262571495700=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] sms: SMS-DELIVER TP-OA Alphanum decoding and encoding fix
Date: Fri, 13 Feb 2015 10:01:55 -0600
Message-ID: <54DE1FF3.1040904@gmail.com>
In-Reply-To: <87e97632c94a76a5c5391485a0a5e34637ed8a50.1423832864.git.tommi.kenakkala@tieto.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1325039262571495700==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Tommi,

On 02/13/2015 09:50 AM, Tommi Kenakkala wrote:
> TP-OA max length comparisons were incorrect because TP-OA's 7-bit
> coded octets transport eleven 8-bit chars which take 23 bytes in UTF-8.
> Increase address array accordingly and don't compare byte length to
> character limit, but to a proper limit.
> ---
>   src/smsutil.c |   12 +++++++++---
>   src/smsutil.h |    6 +++++-
>   2 files changed, 14 insertions(+), 4 deletions(-)
>

Applied after tweaking the commit description.

Thanks,
-Denis


--===============1325039262571495700==--

