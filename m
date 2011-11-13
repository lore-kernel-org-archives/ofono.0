Content-Type: multipart/mixed; boundary="===============4798218644342469263=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: DUN done right (was Re: ofono plugin)
Date: Sun, 13 Nov 2011 21:13:35 +0100
Message-ID: <4EC024EF.5040501@monom.org>
In-Reply-To: <4EB15A8A.7050105@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4798218644342469263==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Everyone,

On 11/02/2011 03:58 PM, Denis Kenzior wrote:
> Hi Daniel,
> =

>> - DUN: ConnMan should directly talk to BlueZ. There are too many issues
>> with having oFono in the middle. There is a strong relation ship between
>> PAN and DUN and ConnMan needs to be aware of it. Think about the kill
>> switch for bluetooth.
>>
> =

> This is not so clear cut.  The gatchat library is an ofono exclusive
> right now, and putting it into BlueZ might be somewhat 'controversial'.
>  The other option is of course to create a separate daemon inside the
> ofono source tree...
> =

> It may be that we need to discuss how Bluetooth / PAN is modeled in
> ConnMan and whether we should do the same for DUN or not first.

Yes we should discuss this topic soon. I'd like to get this working.
Would it be possible to have this discussion this week on IRC? What is
the preferred time and date?

Would Tuesday 15.11.2011 16:00 CET work for those on CC? Of course
anyone else is also invited. I just can't remember who is also
interested in this discussion.

Date: 15.11.2011 16:00 CET
network: freenode.net
channel: #connman_dun

cheers,
daniel



--===============4798218644342469263==--

