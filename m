Content-Type: multipart/mixed; boundary="===============2565907403209563858=="
MIME-Version: 1.0
From: Gu, Yang <yang.gu@intel.com>
Subject: RE: [PATCH] sim: Read EFsst
Date: Thu, 26 Aug 2010 18:12:00 +0800
Message-ID: <CE761E84DADF2947A4AF22FB8D97A4732A516D1E@shsmsx501.ccr.corp.intel.com>
In-Reply-To: <4C755013.3040603@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2565907403209563858==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,


>> +static void sim_efust_read_cb(int ok, int length, int record,
>> +				const unsigned char *data,
>> +				int record_length, void *userdata)
>> +{
>> +	struct ofono_sim *sim =3D userdata;
>> +
>> +	if (!ok)
>> +		goto error;
>> +
>>  	if (length < 1) {
>>  		ofono_error("EFust shall contain at least one byte");
>>  		goto out;
>> @@ -1073,6 +1096,12 @@ static void sim_efust_read_cb(int ok, int length,=
 int
>record,
>>
>>  out:
>>  	sim_retrieve_imsi(sim);
>> +	return;
>> +
>> +error:
>> +	ofono_sim_read(sim, SIM_EFSST_FILEID,
>> +			OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
>> +			sim_efsst_read_cb, sim);
>>  }
>
>That is really not how it works.  If the file ID is the same then you
>need some other information to determine whether this is a phase 3 or a
>phase 2 SIM.  Look at how EFecc reading in voicecall.c is done.  In
>other words, this function needs to make an intelligent decision whether
>this is EFsst or EFust.
>
>In your case the only heuristic we have is EFphase, which is mandatory
>for all Phase 2 SIMs (and absent in all Phase 3 SIMs).

Last time, you mentioned " 3G device + 3G sim -> EFust and EFest, while 2G =
device + 3G sim -> EFsst". And I think EFphase only means the SIM phase. So=
 just using SIM phase to do the judgement would put us in a risk if we have=
 a phase 3 SIM and 2G device, right? You also mentioned this is the best wa=
y we currently have. Do you hint we have no (general) way to get the phase =
of device?

But I still think there is some problem here: For this case, EFust and EFss=
t have the same file id and type. So I suppose they can't co-exist in the S=
IM file system. Otherwise, we couldn't read them by just using the file id =
and file type. If so, and if I were a SIM manufacturer, how should I decide=
 which one, EFust and EFsst, will be put in? I would have no knowledge what=
 the phase of user's device. So the rule to obey is to have my choice match=
 the EFphase. That is, 3G sim -> EFust and 2G sim ->EFsst.

Another two related questions: 1) Can we have two files with different id b=
ut same purpose, one for phase 2 and the other for phase 3, coexist in SIM =
file system? Thinking about if we change the id of EFsst. This case also hi=
nts one of them must be invalid if it's allowed. 2) Can we have two files w=
ith same id but different types coexist in SIM file system? According to th=
e assumption of current code with EFecc, I think the answer is no. Just nee=
d a confirmation. =


Regards,
-Yang

--===============2565907403209563858==--

