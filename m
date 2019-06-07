Content-Type: multipart/mixed; boundary="===============5009077932314568818=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] netmon: adding get functionality for neighbouring cell
 information
Date: Fri, 07 Jun 2019 11:18:16 -0500
Message-ID: <82316e4a-0421-edd6-14a7-218421de0d72@gmail.com>
In-Reply-To: <9BCC1739A7EADA4790E1FFF4123FB3268BB1CEC5@BGSMSX101.gar.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5009077932314568818==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Antara,

On 06/07/2019 12:48 AM, Borwankar, Antara wrote:
> Hi Denis,
> =

> Actually right now xmm modem is returning "0xFFFFFFFF" for most of the ce=
ll id for neighbouring cells.
> I am following this issue with my modem team.
> I had changed it not realising netmon is being used by ril modem also. I =
have changed it back to UINT32.

*Please* don't introduce such easter eggs in the future.  If you have a =

reason to change the API, then lets discuss that in a separate commit =

with a paper trail as to why you're doing that.

Regards,
-Denis

--===============5009077932314568818==--

