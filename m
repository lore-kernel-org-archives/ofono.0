Content-Type: multipart/mixed; boundary="===============8403524069624631245=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: Re: [PATCH v2] tools: add client to receive location reporting
Date: Wed, 23 Feb 2011 23:34:19 -0300
Message-ID: <AANLkTinXrYzbFeeJvD_HEO2zsXuTZJGkn89w2g7x07iz@mail.gmail.com>
In-Reply-To: <4D65AD26.5090803@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8403524069624631245==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis

On Wed, Feb 23, 2011 at 9:58 PM, Denis Kenzior <denkenz@gmail.com> wrote:
> Hi Lucas,
>
> On 02/23/2011 01:49 PM, Lucas De Marchi wrote:
>> As of now there's no support for fd-passing in D-Bus Python bindings,
>> hence a small C client is needed in order to test location-reporting
>> atom.
>> ---
>> =C2=A0Makefile.am =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A05 +-
>> =C2=A0tools/get-location.c | =C2=A0259 +++++++++++++++++++++++++++++++++=
+++++++++++++++++
>> =C2=A02 files changed, 263 insertions(+), 1 deletions(-)
>> =C2=A0create mode 100644 tools/get-location.c
>>
>
> Patch has been applied, but please check my follow on commit for
> correctness.
>

You are right. In the test app I forgot the poor guys that don't have
fd-passing.


thanks for fixing that.


regards,
Lucas De Marchi

--===============8403524069624631245==--

