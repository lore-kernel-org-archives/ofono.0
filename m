Content-Type: multipart/mixed; boundary="===============3323081934486764290=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: TODO: Network updating the emergency number list
Date: Tue, 21 Dec 2010 16:21:33 -0600
Message-ID: <4D11286D.6030307@gmail.com>
In-Reply-To: <C681C76E0D5F1E4BB01DE79E0A80EEC702DE3D12@usrdes03.ebgroup.elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3323081934486764290==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Rajesh,

On 12/21/2010 04:14 PM, Rajesh.Nagaiah(a)elektrobit.com wrote:
> Hi Denis / Petteri,
>  =

>>> Network downloaded emergency number-list can also contain emergency =

>>> call type in the category-field (for instance "Police", =

>>> "Ambulance"...). This kind of information is not included =

>> for example =

>>> in SIM EFecc-file, so Emergency-number property returns in =

>> this moment =

>>> just the ECC-number without the category. What do you think, should =

>>> this also be included in the Emergency-property?
>>
>> I believe the EFecc described in 31.102 also contains the =

>> category information.  So we can certainly change the API to =

>> provide this information or an empty string if unknown.  =

>> However, since the category information is a bitmap, mapping =

>> this to an API in a nice manner can be quite challenging.  =

>> Feel free to propose something.
> =

> Is the emergency number category really used on the AP SW side ? =

> All we do is to check the number against the ECC list to see its =

> going to use the dedicated emergency services channel in the radio =

> interface for that call or not, irrespective of the category type.
> If we are going to have an UI thats going to list ECC numbers and its =

> corresponding category, then this information is useful, but I have
> never seen such UI in other platforms as well.

22.101 hints that such UI is a possibility.  However, I tend to agree
that this information isn't terribly useful otherwise.

The other stumbling block is that EFecc in 51.011 and 11.11 never
contained the information about the emergency number category in the
EFecc fields...

Regards,
-Denis

--===============3323081934486764290==--

