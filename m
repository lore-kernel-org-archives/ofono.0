Content-Type: multipart/mixed; boundary="===============5742230436128039315=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] hfp: Handle extra CCWA event
Date: Mon, 24 Aug 2015 16:29:50 -0500
Message-ID: <55DB8CCE.7000107@gmail.com>
In-Reply-To: <1439920408-6936-1-git-send-email-kubax.t.pawlak@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5742230436128039315==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kuba,

On 08/18/2015 12:53 PM, Kuba Pawlak wrote:
> When a call is waitng, CCWA event is sent and call object
> in state WAITING is created. on ReleaseAndAnswer it is
> promoted to INCOMING and later to ACTIVE.
> iPhones send an extra CCWA event when active call is ended.
> This extra event is creating a second call object in state
> WAITING. It is not possible to have two WAITING calls, but
> previously waiting call was already promoted to INCOMING.
> For a brief time we have two calls from the same number,
> one INCOMING and one WAITING. Later WAITING one is removed.
> As we cannot have a waiting and incoming call at the same
> time, ignore CCWA when there is already an INCOMING call.
>

Applied, thanks.

Regards,
-Denis


--===============5742230436128039315==--

