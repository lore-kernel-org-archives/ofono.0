Content-Type: multipart/mixed; boundary="===============4912044997690212408=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] test-ussd becomes send-ussd
Date: Mon, 09 Jul 2012 11:52:12 -0500
Message-ID: <4FFB0C3C.8010906@gmail.com>
In-Reply-To: <1341851969.16443.0.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4912044997690212408==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

On 07/09/2012 11:39 AM, Marcel Holtmann wrote:
> Hi Denis,
>
>>> ---
>>>    test/send-ussd |   75 ++++++++++++++++++++++++++++++++++++++++++++++=
++++++++++
>>>    test/test-ussd |   75 ----------------------------------------------=
----------
>>>    2 files changed, 75 insertions(+), 75 deletions(-)
>>>    create mode 100755 test/send-ussd
>>>    delete mode 100755 test/test-ussd
>>>
>>
>> Why don't we just get rid of test-ussd and create a new send-ussd script
>> that doesn't do any stdin handling.  Something along the lines of:
>>
>> ss.GetProperties()
>>
>> if state =3D=3D 'idle'
>> 	rsp =3D ss.Initiate()
>> elif state =3D=3D 'user-response'
>> 	rsp =3D ss.Respond()
>>
>> print response
>>
>> And perhaps another ussd related script that just cancels the request.
>> Would this satisfy your requirements?
>
> are the existing test/initiate-ussd and test/cancel-ussd not good
> enough?
>

initiate-ussd is close but not quite, it doesn't handle network =

initiated USSDs.

Anyway, the point here is that we need to get rid of test-ussd, it =

really serves no purpose.

Regards,
-Denis

--===============4912044997690212408==--

