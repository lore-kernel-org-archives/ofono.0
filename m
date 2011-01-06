Content-Type: multipart/mixed; boundary="===============7075119081576715460=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC PATCH] gprs: add function to handle activated context
Date: Thu, 06 Jan 2011 12:10:03 -0600
Message-ID: <4D26057B.8030506@gmail.com>
In-Reply-To: <AANLkTimEnzUrSuJtSJuvUp+vNGANi6rsWgvAnHhb_j0J@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7075119081576715460==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sjur,

On 01/06/2011 11:45 AM, Sjur Br=C3=A6ndeland wrote:
> Hi Marcel and Denis.
> =

>> I thought that we came to the conclusion that CID=3D0 is pretty much a
>> really bad idea. So I would prefer that your modem is actually not using
>> CID=3D0 ever.
> Yea, I know you or Denis said so, but I'm not sure we understood your con=
cern...
> =


The bottom line is that the network can ask for a context to be
initiated at any time.  Furthermore, any number of such contexts can be
activated.  You can't really treat LTE specially and CID=3D0 really
doesn't help you anyway.

e.g.:

<cr><lf>+CGEV: NW PDN ACT 1<cr><lf>
...
<cr><lf>+CGEV: NW PDN ACT 2<cr><lf>

You need to allocate these cids properly.  However, solving the cid
allocation problem in the general case is basically impossible.  The
spec is just not setup to do so in its current form.

e.g.

---> context1.SetActive(True);
idmap_alloc(cid_map) -> cid =3D=3D 1
[+CGDCONT=3D1,...]

<----
<cr><lf>+CGEV: ME PDN ACT 1<cr><lf>

Bad things happen.

The best you can do is allocate these cids from a different range than
oFono.  e.g.:

AT+CGDCONT=3D?
+CGDCONT: (0-25)

ofono_gprs_set_cid_range(gprs, 12, 25)

This way oFono will use the upper range for stack initiated contexts and
you guys have the lower range to play in.

Regards,
-Denis

--===============7075119081576715460==--

