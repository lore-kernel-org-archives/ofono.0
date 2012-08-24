Content-Type: multipart/mixed; boundary="===============1755469769952340334=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 0/4] Immediate digit response
Date: Fri, 24 Aug 2012 10:52:32 -0500
Message-ID: <5037A340.3060400@gmail.com>
In-Reply-To: <1345818505-17175-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1755469769952340334==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

On 08/24/2012 09:28 AM, Philippe Nunes wrote:
> For GET-INPUT proactive command, the command qualifier can require
> to send the response immediately after the user has entered a digit.
> In this mode, the entered digit shall not be displayed and the character
> '+' is not allowed for user input.
>
> Philippe Nunes (4):
>    stk: check if immediate digit response is requested
>    stkagent: Add argument to notify when immediate digit response is
>      required
>    doc: Update STK API regarding the new argument immediate_response
>    test: Print the immediate_response argument for RequestDigit
>

This patch ordering makes no sense.  The doc changes should be first, =

followed by stkagent changes followed by stk changes and then the test =

scripts.  Remember you want to break git bisect as little as possible.

Regards,
-Denis

--===============1755469769952340334==--

