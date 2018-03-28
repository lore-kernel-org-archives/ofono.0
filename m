Content-Type: multipart/mixed; boundary="===============8312603031606243091=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: Re: [RFC PATCH 04/30] qmi: request_alloc has no meaningful failure
 path
Date: Wed, 28 Mar 2018 22:51:41 +0200
Message-ID: <1e41b3cc-ff54-be3e-1ccd-714501e52c81@southpole.se>
In-Reply-To: <57eb1632-6f04-460c-01bb-7fb1e7679756@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8312603031606243091==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



On 28/03/18 21:59, Denis Kenzior wrote:
> ---
>> =C2=A0 drivers/qmimodem/qmi.c | 32 ++------------------------------
>> =C2=A0 1 file changed, 2 insertions(+), 30 deletions(-)
>>
>> diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
>> index 0c95dd18..85ed9ddc 100644
>> --- a/drivers/qmimodem/qmi.c
>> +++ b/drivers/qmimodem/qmi.c
>> @@ -171,9 +171,7 @@ static struct qmi_request *__request_alloc(struct =

>> qmi_device* device,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct qmi_message_hdr *msg;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint16_t headroom;
>> =C2=A0 -=C2=A0=C2=A0=C2=A0 req =3D g_try_new0(struct qmi_request, 1);
>> -=C2=A0=C2=A0=C2=A0 if (!req)
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NULL;
>> +=C2=A0=C2=A0=C2=A0 req =3D calloc(1, sizeof(*req));
>
> Why now g_new0?=C2=A0 What's your plan here, are you wanting to get rid o=
f =

> glib entirely?=C2=A0 If so, then we might as well start using ell for QMI=
, =

> which is a long term goal anyway.

Well, you did say that getting rid of glib was a long term goal. =

Introducing ell introduces a new library; calloc() is a standard libc =

function.=C2=A0 I=C2=A0 did look at ell but deemed that introducing ell at =
the =

same time as trying to untangle the QMI mess was beyond the budget that =

I have allocated for this work.

Based on what you have said earlier, I am working under the assumptions =

that:
i)=C2=A0 glib is of no importance and it would be desirable to remove the =

dependency on it
ii)=C2=A0 ofono is Linux-only

/Jonas


--===============8312603031606243091==--

