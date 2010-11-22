Content-Type: multipart/mixed; boundary="===============8101168656017719074=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 3/4] phonesim: Add Timer Management commands to sim app
 menu.
Date: Mon, 22 Nov 2010 09:09:42 -0600
Message-ID: <4CEA87B6.4010500@gmail.com>
In-Reply-To: <1290354698-15749-3-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8101168656017719074==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 11/21/2010 09:51 AM, Andrzej Zaborowski wrote:
> ---
>  src/qsimcommand.cpp          |   83 ++++++++++++++++++++
>  src/qsimcommand.h            |    3 +
>  src/qsimterminalresponse.cpp |   59 ++++++++++++++
>  src/qsimterminalresponse.h   |    3 +
>  src/simapplication.cpp       |  171 ++++++++++++++++++++++++++++++++++++=
++++++
>  src/simapplication.h         |    6 ++
>  6 files changed, 325 insertions(+), 0 deletions(-)
> =


  CXX    src/qsimcommand.o
src/qsimcommand.cpp: In static member function =E2=80=98static QSimCommand
QSimCommand::fromPdu(const QByteArray&)=E2=80=99:
src/qsimcommand.cpp:2713: error: =E2=80=98uint8_t=E2=80=99 was not declared=
 in this scope
src/qsimcommand.cpp:2713: error: expected =E2=80=98)=E2=80=99 before =E2=80=
=98pdu=E2=80=99
src/qsimcommand.cpp:2714: error: expected =E2=80=98)=E2=80=99 before =E2=80=
=98pdu=E2=80=99
src/qsimcommand.cpp:2715: error: expected =E2=80=98)=E2=80=99 before =E2=80=
=98pdu=E2=80=99
src/qsimcommand.cpp:2716: error: expected =E2=80=98)=E2=80=99 before =E2=80=
=98pdu=E2=80=99
src/qsimcommand.cpp:2717: error: expected =E2=80=98)=E2=80=99 before =E2=80=
=98pdu=E2=80=99
src/qsimcommand.cpp:2718: error: expected =E2=80=98)=E2=80=99 before =E2=80=
=98pdu=E2=80=99

Regards,
-Denis

--===============8101168656017719074==--

