Content-Type: multipart/mixed; boundary="===============3732056523752812191=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v7 6/7] gemalto/lte: Gemalto vendor lte atom
Date: Sat, 20 Oct 2018 11:27:23 -0500
Message-ID: <acab5c9a-b52e-bb73-66b9-88d4f3b416c9@gmail.com>
In-Reply-To: <CAKSBH7GBW5BpWXqui2W3=qv5t2gfYhq8-4OUo0uaBq6m3K0ifg@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3732056523752812191==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Giacinto,

On 10/20/2018 11:24 AM, Giacinto Cifelli wrote:
> Hi Denis,
>>
>> I still don't get this explanation.  You have a gemalto specific
>> function, which is being passed the CID directly by the caller.  Why is
>> there weird logic here to mess with the CID, just have the caller pass
>> in the proper CID directly.
>>
>> Also note that cid 1 and 3 are by default valid CIDs for context
>> activations.  So your 'default attach' profile can be overridden by the
>> core at any time.  So you may want to address this by setting the cid
>> range appropriately.
> =

> The function is to be called also from gprs-context, therefore passing
> 0 it knows it has to check whether it has to use 1 or 3 or something
> else.

Sure, but fundamentally it is still gemalto specific, so why would you =

call it with cid=3D0 anyway?

> The cid-ranges are set in the plugin, also because I cannot use
> AT+CGDCONT=3D? with all models.
> There are some that return an answer to this command like (1-16),
> which is ok, but then we have some that return (1,2,3,4,5,6), and
> still other (1-10,17)...

That is all fine, but the logic to determine the cid belongs outside the =

utility function.

Regards,
-Denis

--===============3732056523752812191==--

