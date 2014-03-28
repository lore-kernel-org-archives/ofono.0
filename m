Content-Type: multipart/mixed; boundary="===============6282194579234600243=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: wwan0 interface without IP
Date: Fri, 28 Mar 2014 10:26:52 -0500
Message-ID: <533594BC.1040308@gmail.com>
In-Reply-To: <lh44s7$s5$1@ger.gmane.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6282194579234600243==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Eric,

On 03/28/2014 10:35 AM, Eric BOUXIROT wrote:
>> oFono does not assign the IP parameters.  ConnMan does that or you need
>> to do this some other way.
> =

> i'm right with you but i don't know how ofono deal with connman to trig
> DHCP.
> i know ofono send some parameters (or connman read it on ofono..) like
> "method" "address" etc..
> i know when reading "address" the result is NULL and fail next step in
> connman du to NULL.
> =


After activating the context, run test/list-contexts in oFono git.  What
does it say?

Regards,
-Denis

--===============6282194579234600243==--

