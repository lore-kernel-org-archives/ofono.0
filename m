Content-Type: multipart/mixed; boundary="===============6065536964763929662=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 0/3] Add STK APDU editor
Date: Tue, 28 Aug 2012 09:47:21 -0500
Message-ID: <503CD9F9.101@gmail.com>
In-Reply-To: <1345797155-27517-1-git-send-email-nicolas.bertrand@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6065536964763929662==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Nicolas,

On 08/24/2012 03:32 AM, Nicolas Bertrand wrote:
> Add to phonesim the capability to symply send STK APDU
>
> Nicolas Bertrand (3):
>    phonesim: accept STK command without application
>    controlbase_ui: Add manual stk command editor
>    control: Link functionnality to STK command editor
>
>   src/control.cpp    |   12 ++++++++++++
>   src/control.h      |    2 ++
>   src/controlbase.ui |   46 ++++++++++++++++++++++++++++++++++++++++++++++
>   src/phonesim.cpp   |    8 ++++++--
>   4 files changed, 66 insertions(+), 2 deletions(-)
>

I don't like this idea at all, pasting arbitrary PDUs is slow, error =

prone and does not encourage any sort of automation.  While Phonesim is =

meant for people who know what they're doing, I'd still like to maintain =

at least some resemblance of user-friendliness.

If you really need some way of sending PDUs that phonesim is incapable =

of, feel free to modify the conformance application to emit the PDU in =

question.

Regards,
-Denis

--===============6065536964763929662==--

