Content-Type: multipart/mixed; boundary="===============8144293533612425307=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v4 0/2] Add support for modem handled setup call proactive
 command
Date: Mon, 25 Jul 2011 23:00:16 -0500
Message-ID: <4E2E3BD0.3010402@gmail.com>
In-Reply-To: <1311617727-10294-1-git-send-email-jeevaka.badrappan@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8144293533612425307==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jeevaka,

On 07/25/2011 01:15 PM, Jeevaka Badrappan wrote:
> Hi,
> =

> This patch set fixes the review comments.
> =

> If the modem is able to setup the call, then the alpha id will be freed w=
hen the
> initiated call ends.
> =

> If the modem is not able to setup the call due to some reason, then the m=
emory
> allocated for alpha id and dial request are freed when the command end/se=
ssion
> end is received.
> =


I went ahead and applied both of these patches.  I did do some minor
refactoring afterwards, please test and let me know whether I broke
something.

> Also, noticed there is a break missing in the ofono_stk_proactive_command=
_handled_notify
> for STK_COMMAND_TYPE_SEND_SS case. Fix for that will be provided as a sep=
arate patch.

I went ahead and fixed this as well.

> =

> Note: This version of the patch is not tested.
> =

> Thanks and Regards,
> Jeevaka
> =


Regards,
-Denis

--===============8144293533612425307==--

