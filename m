Content-Type: multipart/mixed; boundary="===============2705106427605127135=="
MIME-Version: 1.0
From: Tom Nguyen <tomirq@earthlink.net>
Subject: Re: [PATCH v3] qmimodem: support wake on SMS receive
Date: Sat, 28 Sep 2019 01:48:39 +0000
Message-ID: <1526726576.4207.1559751760966@wamui-aurora.atl.sa.earthlink.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2705106427605127135==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

>From: Denis Kenzior <denkenz@gmail.com>
>
>Hi Tom,
>
>>>> Also, it may be clearer if the introduction of raw_read and the
>>>> refactoring of this function are done as a separate commit.
>>>>
>>>
>>> Hmm, looking at the "Quectel EC21" comment again, looks like the origin=
al code was done to address a quirk (ie, bug???) with that modem. I'll reve=
rt to reading both.
>
>Jonas was the one who introduced that, so he would be the one to ask :)
>
>>>
>>> But, per spec, the 2 message TLVs are mutually exclusive, depending on =
the route action configuration. I'm referring to setting "new_list->route[0=
].action =3D" in get_routes_cb(). So, we shouldn't need to always read both=
 since one is guaranteed to fail.
>>>
>>> Also, the original code, if somehow both "notify" and "message" are NUL=
L, it'll erroneously use a null notify. I'll address this in the revert.
>>>
>> =

>> On 2nd thought, my change is still ok per that "Quectel EC21" comment. I=
'll keep my changes and add =

>
>Yes, it looked like it would work even for the quirky ec21, but I don't =

>have enough context to say for sure.  Nor do I have a EC21 to test
>
>comment to explain the 2 TLV that are being queried. Also, I introduced =

>raw_read because I need to pull QMI_WMS_RAW_READ out of event_notify to =

>service both event_notify and the message list. So, I'd like to keep =

>this in the same commit.
>
>Yes exactly my point.  You can have the first commit simply perform the =

>'pull QMI_WMS_RAW_READ out of event_notify' transformation, which is =

>more or less self-contained.  And then the second commit would use that =

>new utility function in your message list code.
>
>Smaller commits are easier to review.  When I mentor new contributors I =

>always encourage them to split up their code as much as possible.  In =

>this particular instance I won't insist too hard since it is likely fine =

>either way :)
>
>Regards,
>-Denis

Thank you, thank you, thank you for being lenient with me :)
I can appreciate incremental patches, will keep that in mind for future.
Now, lets see if my 4th update patch will post without problem...

Thanks,
Tom

--===============2705106427605127135==--

