Content-Type: multipart/mixed; boundary="===============8270403278279531414=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2] Synchronize call status in case of Hangup error
Date: Wed, 05 Aug 2015 11:16:20 -0500
Message-ID: <55C236D4.40503@gmail.com>
In-Reply-To: <1438778169-12297-1-git-send-email-kubax.t.pawlak@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8270403278279531414==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kuba,

On 08/05/2015 07:36 AM, Kuba Pawlak wrote:
> It is possible for the phone to accept Dial request
> but not actually dial. This leaves a voicecall object
> in state 'dialling' that cannot be removed.
> Proposed workaround is to trigger AT+CLCC when an error
> is returned for Hangup. As the call is not on the list,
> this would remove this hanging object and signal CallRemoved.
>

Applied, thanks.

Regards,
-Denis


--===============8270403278279531414==--

