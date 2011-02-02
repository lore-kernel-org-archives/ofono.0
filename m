Content-Type: multipart/mixed; boundary="===============5299826384304177003=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/2] voicecall: try harder to avoid Dial mismatches
Date: Tue, 01 Feb 2011 19:24:50 -0600
Message-ID: <4D48B262.8060006@gmail.com>
In-Reply-To: <1296598930-3093-2-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5299826384304177003==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pekka,

On 02/01/2011 04:22 PM, Pekka.Pessi(a)nokia.com wrote:
> From: Pekka Pessi <Pekka.Pessi@nokia.com>
> =

> There were some cases where Dial returned an incorrect call object,
> e.g., after oFono crash and recover.
> ---
>  src/voicecall.c |   15 +++++++++++++++
>  1 files changed, 15 insertions(+), 0 deletions(-)
> =


So I'm guessing that you're restarting oFono and get
ofono_voicecall_notify events without setting dial_result_handled properly.

Do you think it is a better idea to resurrect the old list_calls driver
method and fire this off explicitly when the atom is registered?  The
callback can then take care of setting dial_result_handled appropriately.

Regards,
-Denis

--===============5299826384304177003==--

