Content-Type: multipart/mixed; boundary="===============4218732381917102863=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: Re: [RFC hwdb v1 20/28] telitqmi: drop unused device rule
Date: Fri, 31 Mar 2017 12:37:25 +0200
Message-ID: <56d262bd-2ac0-5cb7-16d8-ae287b1864ab@southpole.se>
In-Reply-To: <0236a140-5fe2-2e07-209e-7c7505cb2d8c@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4218732381917102863==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 03/31/2017 10:35 AM, Lukasz Nowak wrote:
> Hi Jonas,
>
> On 30/03/17 21:53, Jonas Bonn wrote:
>> The rule might match for some device but setup_telitqmi does not attempt
>> to do anything for interfaces that aren't driven by the qmi_wwan driver
>> so it's pointless.
> As I described before, this rule is not pointless, it prevents this rule:
>    	{ "telit",	"option",	"1bc7"		},
>
> from taking over the device, and using setup_telit instead of setup_telit=
qmi.
>
> Lukasz

Yes, but in the context of the transition to hwdb it should not be =

necessary anymore.  That said, I see the problem and I think it still =

persists in the hwdb model.  The problem is the Telit catch-all rule; we =

really need to get rid of it but that risks rendering a bunch of modems =

that work today non-functional.  This needs some thought.

/Jonas

>
>
>> ---
>>   plugins/udevng.c | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/plugins/udevng.c b/plugins/udevng.c
>> index 3aef447..d02cc6e 100644
>> --- a/plugins/udevng.c
>> +++ b/plugins/udevng.c
>> @@ -1324,7 +1324,6 @@ static struct {
>>   	{ "telit",	"usbserial",	"1bc7"		},
>>   	{ "telit",	"option",	"1bc7"		},
>>   	{ "telit",	"cdc_acm",	"1bc7", "0021"	},
>> -	{ "telitqmi",	"option",	"1bc7", "1201"	},
>>   	{ "quectel",	"option",	"05c6", "9090"	},
>>   	{ "telit",	"cdc_ncm",	"1bc7", "0036"	},
>>   	{ "telit",	"cdc_acm",	"1bc7", "0036"	},
>>


--===============4218732381917102863==--

