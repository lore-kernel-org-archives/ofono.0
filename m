Content-Type: multipart/mixed; boundary="===============2232157951409970367=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Randomly SMS sent passes or fails
Date: Tue, 02 Apr 2013 10:08:07 -0500
Message-ID: <515AF457.2000102@gmail.com>
In-Reply-To: <515AE1E5.5040606@syscom-instruments.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2232157951409970367==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Anthony,

On 04/02/2013 08:49 AM, Viallard Anthony wrote:
> Hi Denis and ofono guys,
>
> I hope you enjoy Easter celebration !
>
>>
>> Actually, this is peculiar, the CRSM command is not failing and the
>> result is fine. Just that it is empty. Perhaps you need to quirk the
>> CRSM behavior in this case. Does adding your modem to the list in
>> at_sim_read_info()
>>
>> /* Maximum possible length */
>> len +=3D sprintf(buf + len, ",0,0,255");
>> break;
>>
>> make it work properly?
>
> I added the quirk as above and Yes ! I've got values now:
>
> -------------------------------------
> ofonod[11230]: Data: > AT+CRSM=3D178,28614,1,4,8\r
> ofonod[11230]: Data: < \r\n+CRSM: 144,0,"62F2100000FFFE01"\r\n\r\nOK\r\n
> ofonod[11230]: drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90,
> 00, 8
> -------------------------------------
>
> and SMS work ! Actually, It works if GPRS isn't Active... If I enable

Good

> GPRS, It fails with message CMS ERROR: 500 (Unknown error):
>
> -------------------------------------
> ofonod[11230]: Data: > AT+CMGS=3D49\r
> ofonod[11230]: Data: < \r\n>
> ofonod[11230]: Data: >
> 0011000B911487584414F70000A728C8329BFD0699E5EF368858AED3C76866D84D06DDD37=
43468DA9C82DEF6B21C74844AA7<CtrlZ>
>
> ofonod[11230]: Data: < \r\n
> ofonod[11230]: Data: < \r\n+CMS ERROR: 500\r\n
> ofonod[11230]: src/sms.c:tx_finished() tx_finished 0xfecf8
> ofonod[11230]: src/sms.c:sms_tx_queue_remove_entry() 0xfecf8
> -------------------------------------
>
> So, I guess when I enable GPRS, my GSM module wants to send SMS over
> GPRS... And maybe, I can't because ofono always fails on provisioning:
>

I doubt provisioning has anything to do with this.  That is only for =

activating a context.

> -------------------------------------
> ofonod[7135]: src/gprs-provision.c:__ofono_gprs_provision_get_settings()
> Calling provisioning plugin 'Provisioning'
> ofonod[7135]: plugins/provision.c:provision_get_settings() Provisioning
> for MCC 262, MNC 01, SPN 'Telekom.de'
> ofonod[7135]:
> /usr/share/mobile-broadband-provider-info/serviceproviders.xml:1562
> Duplicate context detected
> ofonod[7135]: Provisioning failed
> -------------------------------------
>
> I read the source code which can explain the issue. I guess the problem
> isn't really a problem. There 2 apn tags in serviceproviders.xml for
> T-Mobile. This is why I've got "Duplicate context detected" message.
>
> As I understand, the provision plugin wants only 1 apn (allow_duplicates
> is FALSE) by MCC/MNC. Why ? There are many others operators (according
> to serviceproviders.xml) who have more than 1 apn. So, for these, the
> provisioning always fails ?

This is automatic provisioning.  If there are multiple possibilities =

that fit, then this requires user input.  Obviously oFono does not =

support user input, so a UI of some sort to finish provisioning is required.

>
> Maybe I must write an another provision plugin which supports multiples
> apn entries ? It's tricky to implement this ?

You can certainly do this, however you still need to know which context =

to activate.

Regards,
-Denis

--===============2232157951409970367==--

