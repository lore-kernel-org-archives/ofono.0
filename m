Content-Type: multipart/mixed; boundary="===============3190213753369874419=="
MIME-Version: 1.0
From: Aygon, Bertrand <bertrand.aygon@intel.com>
Subject: RE: Trouble using Huwei E160G
Date: Tue, 05 Apr 2011 09:29:51 +0100
Message-ID: <A782C372B9527D44AB20BF45FEEBB14F75BFECF72A@irsmsx503.ger.corp.intel.com>
In-Reply-To: <A782C372B9527D44AB20BF45FEEBB14F75BFECF722@irsmsx503.ger.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3190213753369874419==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi again,

>>>>> 1) Connect 3G key and wait for umts coverage (blue led)
>>>>>
>>>>> I activated the 3g connection, but ofono response is
>>>>>
>>>>> Error org.ofono.Error.NotImplemented: Implementation not provided
>>>> Can you please send the full log for this case, and also the term outp=
ut, so I can see what you are exactly doing.
>>> I have attached the log on test 1 and 2.
>> Can you please add the full output of the oFono test scripts (since the =
./list_modems to the error you have)?
>I have attacced the log for utms, for gprs I have some trouble to get the =
signal now.

Mail has been sent to fast.

After the step 2 (Enable the modem), can you please do ./list-contexts ?

For step 3, you can do ./create-internet-context ibox.tim.it

And for step 4, you can do ./active-context

Regards,

Bertrand.
---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, =

92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

_______________________________________________
ofono mailing list
ofono(a)ofono.org
http://lists.ofono.org/listinfo/ofono
---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, =

92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.


--===============3190213753369874419==--

