Content-Type: multipart/mixed; boundary="===============4087196633104882466=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v4 0/4] Support of Network / Modem updated emergency
 numbers
Date: Thu, 07 Apr 2011 22:20:14 -0500
Message-ID: <4D9E7EEE.7040300@gmail.com>
In-Reply-To: <1302100003-5488-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4087196633104882466==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jeevaka,

On 04/06/2011 09:26 AM, Jeevaka Badrappan wrote:
> Hi,
> =

>  Following set of patch adds the support for emergency number list update
> from the network/modem in the oFono core.
> =

> Regards,
> Jeevaka
> =


I applied all of the patches in this series, but did split patch 2 into
two commits.  Thanks for that.

I also did some minor refactoring after the fact to take care of some
really corner cases.  Can you please review and make sure I didn't screw
anything up.

I believe this should complete emergency call related tasks.  Can we
make sure to test this really well in the coming weeks?

Regards,
-Denis

--===============4087196633104882466==--

