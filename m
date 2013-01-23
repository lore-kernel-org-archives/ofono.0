Content-Type: multipart/mixed; boundary="===============8720909827963405882=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v1 05/10] hfp_hf_bluez5: Handle NewConnection from BlueZ
Date: Wed, 23 Jan 2013 14:32:54 -0600
Message-ID: <510048F6.3030708@gmail.com>
In-Reply-To: <1358965681-7420-6-git-send-email-vinicius.gomes@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8720909827963405882==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Vinicius,

On 01/23/2013 12:27 PM, Vinicius Costa Gomes wrote:
> Parse the essential arguments in the message, in this case only the
> file descriptor, and register the modem if it is not already
> registered. This is necessary because in some cases, we may receive a
> NewConnection call, and the SDP process is still taking place.
> ---
>   plugins/hfp_hf_bluez5.c | 51 ++++++++++++++++++++++++++++++++++++++++++=
++++---
>   1 file changed, 48 insertions(+), 3 deletions(-)
>

Patch has been applied, thanks.

Regards,
-Denis


--===============8720909827963405882==--

