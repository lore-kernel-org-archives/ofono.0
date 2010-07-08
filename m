Content-Type: multipart/mixed; boundary="===============5141495414908256448=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 00/14][RESEND] STK patches without agent
Date: Thu, 08 Jul 2010 14:28:29 -0500
Message-ID: <4C3626DD.8010800@gmail.com>
In-Reply-To: <1278455949-2823-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5141495414908256448==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 07/06/2010 05:38 PM, Andrzej Zaborowski wrote:
> These are some patches I sent before reordered and refactored to
> skip stuff related to the Agent API, i.e. related to the UI.
> =

> Andrzej Zaborowski (14):
>   stk: Utilities for proactive command/envelope handling.
>   mbmmodem: End session on *STKEND.
>   stk: Handle the More Time proactive command as a nop.
>   Add OFONO_ERROR_TYPE_SIM for negative SIM statuses.
>   atmodem: Make sim operations return sim error codes.
>   stk: Handle ENVELOPEs in a queue, retry on sim busy.
>   Add __ofono_sms_submit for other atoms to submit SMs.
>   stk: Handle the Send SMS proactive command.
>   Add Dbus interface names for STK.
>   stk: Handle the Set Up Idle Text proactive command.
>   sktutil: Use the Mandatory flag in parse_dataobj.
>   stkutil: Timer Value is conditional, not optional.
>   stk: Handle the Timer Management proactive command.
>   stk: Handle the Poll Interval proactive command.

All patches in this series have been pushed upstream with some
refactoring afterwards.  Please review and make sure I didn't screw
something up.

Regards,
-Denis

--===============5141495414908256448==--

