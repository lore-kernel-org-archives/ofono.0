Content-Type: multipart/mixed; boundary="===============8284906518647810562=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] simfs: fix incorrect math again
Date: Tue, 02 Nov 2010 09:57:27 -0500
Message-ID: <4CD026D7.5060806@gmail.com>
In-Reply-To: <20101102074108.059f1d24@kcaccard-MOBL3>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8284906518647810562==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kristen,

On 11/02/2010 09:41 AM, Kristen Carlson Accardi wrote:
> On Thu, 14 Oct 2010 11:18:00 -0700
> Kristen Carlson Accardi <kristen@linux.intel.com> wrote:
> =

>> ---
>>  src/simfs.c |    6 ++----
>>  1 files changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/src/simfs.c b/src/simfs.c
>> index fd768ef..bcb6ff8 100644
>> --- a/src/simfs.c
>> +++ b/src/simfs.c
>> @@ -231,8 +231,7 @@ static void sim_fs_op_read_block_cb(const struct ofo=
no_error *error,
>>  		tocopy =3D MIN(256 - op->offset % 256,
>>  				op->num_bytes - op->current * 256);
>>  	} else {
>> -		bufoff =3D (op->current - start_block - 1) * 256 +
>> -				op->offset % 256;
>> +		bufoff =3D op->current * 256;
>>  		dataoff =3D 0;
>>  		tocopy =3D MIN(256, op->num_bytes - op->current * 256);
>>  	}
>> @@ -294,8 +293,7 @@ static gboolean sim_fs_op_read_block(gpointer user_d=
ata)
>>  			toread =3D MIN(256 - op->offset % 256,
>>  					op->num_bytes - op->current * 256);
>>  		} else {
>> -			bufoff =3D (op->current - start_block - 1) * 256 +
>> -					op->offset % 256;
>> +			bufoff =3D op->current * 256;
>>  			seekoff =3D SIM_CACHE_HEADER_SIZE + op->current * 256;
>>  			toread =3D MIN(256, op->num_bytes - op->current * 256);
>>  		}
> =

> Denis - any feedback on this patch?  If we don't add this bugfix,
> reads > 256 bytes will be broken.
> =


I don't believe the patch is correct:

In sim_fs_op_read_block:
...
        if (op->current =3D=3D start_block) {
                op->buffer =3D g_try_new0(unsigned char, op->num_bytes);
...

We don't allocate a buffer for the entire file, just for the portion
we're reading.  So setting buffoff to op->current * 256 will not work on
reads that start at non-zero offsets.

Regards,
-Denis

--===============8284906518647810562==--

