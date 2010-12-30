Content-Type: multipart/mixed; boundary="===============4348492718502514755=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC 2/2] stk: add missing text and icon case handling
Date: Thu, 30 Dec 2010 11:10:10 -0600
Message-ID: <4D1CBCF2.3040101@gmail.com>
In-Reply-To: <1293628600-8684-3-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4348492718502514755==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jeevaka,

On 12/29/2010 07:16 AM, Jeevaka Badrappan wrote:
> As per the ETSI TS 102 223 section 6.5.4,
> If the terminal receives an icon, and either
> an empty or no alpha identifier/text string
> is given by the UICC, than the terminal shall
> reject the command with general result
> "Command data not understood by terminal".
> ---
>  src/stk.c |  114 ++++++++++++++++++++++++++++++++++++++++++-------------=
------
>  1 files changed, 79 insertions(+), 35 deletions(-)
> =


I thought the agreement was to do such checking in stkutil.c?

Regards,
-Denis

--===============4348492718502514755==--

