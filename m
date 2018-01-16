Content-Type: multipart/mixed; boundary="===============6244859560010660791=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] add qmimodem/voice.h to add USSD defines
Date: Tue, 16 Jan 2018 11:19:49 -0600
Message-ID: <82d37c95-c1db-1f65-c177-69d85fadbe08@gmail.com>
In-Reply-To: <20180116153325.20491-1-lynxis@fe80.eu>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6244859560010660791==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Alexander,

On 01/16/2018 09:33 AM, Alexander Couzens wrote:
> USSD is part of the QMI voice service.
> ---
>   drivers/qmimodem/voice.h | 62 +++++++++++++++++++++++++++++++++++++++++=
+++++++
>   1 file changed, 62 insertions(+)
>   create mode 100644 drivers/qmimodem/voice.h
> =


Applied.  I also added a follow on commit to add voice.h to qmi_sources =

in Makefile.am.

Regards,
-Denis


--===============6244859560010660791==--

