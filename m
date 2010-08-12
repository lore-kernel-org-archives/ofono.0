Content-Type: multipart/mixed; boundary="===============6654657679780621302=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC PATCH 5/5] smsutil: save pending status reports to imsi file
Date: Thu, 12 Aug 2010 12:24:42 -0500
Message-ID: <4C642E5A.4010408@gmail.com>
In-Reply-To: <24565F61DC5D5D4BA9D07416A6B5EE6A01C21F@JKLMAIL02.ixonos.local>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6654657679780621302==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Petteri,

On 08/10/2010 11:25 AM, Tikander Petteri wrote:
> Hi Denis,
> =

> I'm the guy, who already introduced shortly yesterday to Inaky, and I'm c=
ontinuing Pasi Miettinen's fine
> work with SMS status-reports.

Good to have you aboard :)

> So, here are some comments (included below) for updating status report-fu=
nctionality for your earlier comments,
> how SR-functionality could be improved.
> =


<snip>

>> General comment here is that you're duplicating much of the code that
>> inserts
>> the information into the data structure.  You can play the same trick as
>> sms_assembly which uses a single function to do the heavy lifting,
>>  but takes
>> an argument whether to store this info on disk.  Obviously during
>>  load you
>> don't want to re-save this information on disk.  Then your load function
>> becomes much smaller and easier to understand.
>>
> =

> OK. I agree that generally single function for heavy lifting is nicer sol=
ution.
> I will implement some general function, which handles adding of new id-ta=
ble (if not already added)
> to assembly-table, and storing necessary node-information there. After th=
at I will move some functionality from
> sr_assembly_load_backup() to this general function. Also this function ca=
n be used when sending new sms-text message.
> And I will add new parameter for telling, if this function will save data=
 to imsi-file on disk or not.
> Existing sms-assembly handles it that way. But, one difference with sms-a=
ssembly and status-report logic is, that
> sms-assembly naturally stores every messages of concatenated, long SMS-me=
ssage to own backup files, but status report
> gathers all information belonging to the same long SMS-message (using mes=
sage reference numbers) to the single file.
> =

> So Pasi implemented in the loading-phase (sr_assembly_load_backup) storin=
g of MR-numbers simply
> by copying the whole buffer containing MR's belonging to the single conca=
tenated message-node:
> =

> 1) memcpy(node->mrs, buf, sizeof(node->mrs));
> =

> And naturally when sending single message, single MR-bit is set up ('stat=
us_report_assembly_add_fragment()'):
> =

> 2) node->mrs[offset] |=3D bit;
> =

> So, when now implementing new general function, one solution could be to =
bring MR-string as parameter
> so way (1) could be used in different cases.
> =

> Also I have to take care of variable 'sent_mrs', which will be incremente=
d in the sms-submit, but not in the loading phase.
>

I agree there are going to be differences.  See how far you get trying
to unify these behind a single function and send for another round of
reviews.

<snip>

>>>       return ret;
>>>  }
>>>
>>> +static gboolean sr_assembly_add_fragment_backup(const char *imsi,
>>> +                                     const struct id_table_node *node,
>>> +                                     unsigned int msg_id)
>>
>> Lets be consistent with how sms assembly works.  E.g. take the main
>>  assembly
>> object and return void.  Just helps to read the code when it is
>>  consistent.
>>
> =

> OK. Lets give main assembly to this (and corresponding) function(s).
> How about return value? For instance existing sms assembly-function 'sms_=
assembly_add_fragment_backup()'
> already returns something else than void.
> =


sms_assembly_add_fragment_backup returns the new list of fragments.
What value can we return from this function?  I think returning
TRUE/FALSE for file write failures are not worth it.  There's not much
that can be done in that case anyway...  So it seems void is good
enough, but feel free to suggest something.

Regards,
-Denis

--===============6654657679780621302==--

