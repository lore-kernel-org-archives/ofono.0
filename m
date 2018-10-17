Content-Type: multipart/mixed; boundary="===============4991773370281566262=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v4 1/2] Gemalto: voicecall atom
Date: Wed, 17 Oct 2018 10:18:04 -0500
Message-ID: <678e682a-6f85-6c42-e1eb-99923c9a6c4a@gmail.com>
In-Reply-To: <cae21e96-7824-6e1c-7bb8-0d73b5139528@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4991773370281566262==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,
>> +
>> +extern void gemalto_voicecall_init();
>> +extern void gemalto_voicecall_exit();
>> +
> =

> Why are these "extern"?
> =


Okay, I haven't had my coffee yet, but what is the actual problem?  All =

functions defined in the header are extern anyway, whether they're =

labeled extern or not.  So, dropping extern would have no actual effect =

besides style.

Regards,
-Denis

--===============4991773370281566262==--

