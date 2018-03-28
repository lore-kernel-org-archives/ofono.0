Content-Type: multipart/mixed; boundary="===============8489002051549129758=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC PATCH 01/30] qmi: remove unused fields of service_send_data
Date: Wed, 28 Mar 2018 16:18:27 -0500
Message-ID: <0b6caf33-cf56-1c8d-8b48-bc8b822b319e@gmail.com>
In-Reply-To: <741a037f-4138-e7a6-88fd-d6e8967b623c@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8489002051549129758==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

>>> +
>>> +=C2=A0=C2=A0=C2=A0 qmi_param_free(param);
>>> +
>>
>> This looks dangerous.=C2=A0 The problem is that all the qmi code issues =

>> qmi_param_free in case qmi_service_send failed.=C2=A0 So you have a doub=
le =

>> free situation here.
> =

> I agree, the patch looks weird.=C2=A0 I was sure this outside of any fail=
ure =

> path, but the context in the patch doesn't reflect that. I'll check again.
> =

> I can say, though, that I've run this change thousands of iterations and =

> I've never hit a double-free...

I believe you.  qmi_service_send probably cannot fail in the current =

setup.  However, we still need to stick to fundamental API guarantees. =

So if the API provides a legitimate failure possibility then it must =

ensure that failure semantics are clear.  For us that usually means:

- No side effects on error.  E.g. any input parameters are not touched / =

freed / generally messed with.
- No output parameters are allocated / touched / generally messed with

I have no issue applying this patch if we drop the qmi_param_free bit.

Regards,
-Denis

--===============8489002051549129758==--

