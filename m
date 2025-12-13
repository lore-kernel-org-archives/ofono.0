Received: from spindle.queued.net (spindle.queued.net [45.33.49.30])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90A12940B
	for <ofono@lists.linux.dev>; Sat, 13 Dec 2025 10:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.33.49.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765620368; cv=none; b=mCI7vD6pgcexSWUTx7ORAkjDkmY9ICzj6TrxnTvD/Q/cHUYZNtH59Ph3sj8/vESKal4LvC/mJC6eSoN4SuNQQkgAbOiiMcEMAJ7+jb7xXARgR7znbgohBZvSlChpK5wK25TnYRsfkyRYP8oq2bsCYZ+KoBpWjTmcw7OvCFiF05A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765620368; c=relaxed/simple;
	bh=Y9+Yg4/AeLZsPGXwjfbQK8UZi8RGEnV6Ju7GWnEowxE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=EmDeUR0h0HPKZ88nI0J1R1eBhiwrz4BePgsO9Ul7RuZo5SFz5uOk7gGsYx44JgShpHca5GXDrsqiOiAa+qPMQSuujmh/iU5bubItxp14scAvMdBY9vX/LmLuDskChGhrjSg1yD0LEkodP7dXNbyDpa+wptMHyHwgedFKHAnSeqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=queued.net; spf=pass smtp.mailfrom=queued.net; arc=none smtp.client-ip=45.33.49.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=queued.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queued.net
Received: by spindle.queued.net (Postfix, from userid 1001)
	id EAAFB114DA1; Sat, 13 Dec 2025 05:06:05 -0500 (EST)
Received: from [192.168.12.220] (unknown [172.56.164.103])
	by spindle.queued.net (Postfix) with ESMTPSA id 5BA56114D91;
	Sat, 13 Dec 2025 05:06:05 -0500 (EST)
Message-ID: <ac6a8d6f-5a28-41ec-b15a-ba8bfdad2fc7@queued.net>
Date: Sat, 13 Dec 2025 05:06:03 -0500
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 7/8] mbim: Add support for SIM I/O operations
To: Muhammad Asif <thevancedgamer@mentallysanemainliners.org>
References: <20251212210249.95597-1-thevancedgamer@mentallysanemainliners.org>
 <20251212210249.95597-8-thevancedgamer@mentallysanemainliners.org>
Content-Language: en-US
From: Andres Salomon <dilinger@queued.net>
Cc: ofono <ofono@lists.linux.dev>
Autocrypt: addr=dilinger@queued.net; keydata=
 xsFNBFQBDrEBEADHJO2YfSTJw+WIhkZYeFiQEXxrGhZjRSdWFoeQH4yk+xOoEGYibQQ8nrrT
 omCGcWdABrHW8jBFgDuqhND8V4U0IH7DNzNYSWtUMEuZsjKswoc9+ZGLGFwLdx/6+prXiq1k
 sKCfPsIVgmu1P/rf85IyNuUPzokBZsgOIF9mb7W22nUWgDeNBvIMidxaYebJ/Oy/8w5qY+Ar
 MHkAo8sE7w53vcsDZYGw114+muHSWnVbbSvdqGkzwNg50x2ZKFnEEX+WAq9KUD0Qkv3CFs6o
 +IUvfZCOTQhWWDq64lpB7cG73eDBmnFjWUJK1qv/GHLlEb98bGfvEs/MY7dXfXrU0edvegNb
 +fmhEpuoxvJg6L/GLGMVvq/5+zNTj7FK8PFj64waUFS0rmJax6JOSOe6VLOn+Dvi+sZssyUX
 uK4RYG2wjtW1Z0oCUitaruCR5MSbsM4L80P5H0iWG4b4sYZJadDv1vQVmoF0EIU9rxFNm9IJ
 sCGCWTA2bdNrvRKMAoZB4ojuDyuQaAVEn+ipa6YMdoRNpuLVs4bnKWXnXr8qHhD/EPwRkZZF
 /2UeLnylDs7l6l7Kn1HztTFg5R+909rKx+fEPi3Eb3DFbP9WytTIB15A+9aoPCKSJFDa+1mz
 K77TtQljBdEDj+UrzAEYrLmh78WyMJq7qFAMPRmVvs+sJcICtwARAQABzSRBbmRyZXMgU2Fs
 b21vbiA8ZGlsaW5nZXJAcXVldWVkLm5ldD7CwXcEEwEIACEFAlQBD6MCGwMFCwkIBwMFFQoJ
 CAsFFgIDAQACHgECF4AACgkQZF0CR8NudjcgMBAAuGlGkrYueMGbaexxscLTjzNlZqFqZ+Z5
 XUxHeiyZ6+m/M5rADNNMyz0Qbff0ldle2gIATFxNGefWWdrMi3wF04it/B8zi4ksTIV0br/x
 oFtFKbwXcJEKennkBo/6hQnCI4BW60v1DQcmICt6V000sWEuRED64D6NWOVTGAmb1D5jIB90
 fSlHDFdn1NewE4r8fanr1RQMhU9ZoOanzPOkqK04A5UorwO+to1mY+syKeYVbj1yhrHSlUXd
 X7IOffLjvjmZkaQh/ghzm5/ih45yk/s++ZjpCm1cYPakho3zPXzIwAPomn6UivpDufKdGvvT
 3y9MciXtZ1qQjpQiWgbHLeSS/3lCIZ8+wFx3cbUCWazQUGhfxNMvd9ZW3TANefwPkB32l5bo
 fNXXA9lRRFlRtSBkme59Hji3OrNABSjGbOF5/wHaTWuQySgPytX2NO78JY4FL3Y+fj7Vk7cH
 m7VN+w1yO1ukd/D7FXkfealDhcfWusMULDN0uhowECHmNs/yoXErGK0l38eq3f4nZJYmNnob
 hPwsvXaBgUZh/sqsZFZgwqhqYr6dkKwFmzSPvHZ/eS80H/kq4dTKSaJOAKjHhiL40mYFMlaC
 I/KJGJS+GVAjm8cv+M3Nd1U8rGMsyUJo95k0iSBdSI4hvqBxw+PbMtYhD+7b7jCEmqfYTaXP
 S6fOwU0EVAEOsQEQAKwfHgc4hCZHOtDRyYN8y8hKF04x5RKW0+i8AMUNCqs/4uiNrMl1Z7vj
 q/rqK2Xxx4P6HQGZeiGxKGSv0qWts3W2cizcjDwHAxFQCSsaapTRb1/7BCzVMRmamUpeP6pW
 9Ok3kC0m/zH7tPf8PU9zMfWlpDjg10BUTPF5EdlHnfjpMCNceMzRUPgx3aysoQHhRcX7lLoP
 ogceM+Lnb/+y39188JXonjZUNZE89DgUuMOSZYybdmmMYMBWYRbRXaiXx8e5MKTHxmFUIyn6
 y+D9UC4lkWDKCSmqDbHFs0fTJyYJCarBvDmIxRI8Xd2COEMlPC6ycOCw+s464MgJdHJ/MI+f
 +jHZvPOrqugszSppKjP3Y00dBL9j5sGaMHrnqqQopupaMTyfwmHtjiJz3UKbMpUJ37ltPGWR
 3tZxvArSwgiMbpHTjeV6cbhN1hFuceN6Zo5k0S8UYoBcmYnj2niJuvesjZ2dd7SIK+Fb/cBz
 IC81ydyP6ld7lfPMZBAgD0IpycHrZuMlVpQ12j11NROIK1fCVkEHB1O22mUZ8xrWQImziF8U
 Ebf/6QtXriD/VUkHB+dmzvoi/eN/jFNvY+h54nqe2lZuwCJbE75srgF8TZlHiILiPpo8tJCD
 frw2nvvl5anj+jXSTugQYLEDTyzJasfvecdEA0DzbA7wxuik0dQTABEBAAHCwV8EGAEIAAkF
 AlQBDrECGwwACgkQZF0CR8NudjfDBw/6AtKiSRK/taYFta88Qr+DKlIctIYOz/fRLoxTnoSM
 HKIVwg/ift6tf0cQGppmQpMeXBeXZTBcRTcjIceaxMOGwDD0PMSlXZ1VaC0ME3JhSHLOoYTk
 oKFnX/Lmij1UaV4x4RjEnu1ry9SSZSVs7cnsqAIqeAwFz6ia3p83dcs8UH2nM5HKYKBGjd8z
 S5RH1nBDsU5NuT2z+7pcXCKakhyDkCkq439gGWH0Y/YXJFWLdZc3vc9v1x/SHQ9LeVIzKCqJ
 kg9ROS6vuNHTZhejJowfnjxIVIXxNDO1B5Pe7sjaFd6UDmo371OSpHnIw8kId4fBd23Mx7hK
 XkptDbiWz35dGzZyW/PcfAQvwAl4p41Yki8ZpVqBv6cmN06u5U1QEiyk78cq779BDVBLg1yF
 TiZkxBZRXKwFm+9AxzWL8/ix8bUeaH19zrpJ4XCRdqUS98d3YBFCnJeD9Oz2y+uym0XLPTy/
 XM1uDcCLSjmQRylJAtUh4dBZ9KsMWUbYjXnSUXxyAS7MrNCe52O0GFdovHelTlaWhVBiSGYi
 f1JOwOC58c8y0ckmcEK9SFp3SRPDjCLrH4Fxp22+fywq6aB/4piRClbpnwqnHh5Xs2BkwS+W
 stksZadd/iuwYCTfjhXPCNmgfATirGHXAbknHg+1WE5XC6VIcYRMnqGRaXE72ieCrMw=
In-Reply-To: <20251212210249.95597-8-thevancedgamer@mentallysanemainliners.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Bogosity: Ham, tests=bogofilter, spamicity=0.000000, version=1.2.5

On 12/12/25 16:02, Muhammad Asif wrote:
> Adds support for complete SIM I/O operations, with complete path
> resolution using sim_ef_db.
[...]
> --- a/drivers/mbimmodem/sim.c
> +++ b/drivers/mbimmodem/sim.c
> @@ -22,14 +22,39 @@
>   #include "drivers/mbimmodem/mbim-message.h"
>   #include "drivers/mbimmodem/mbimmodem.h"
>   
> +struct sim_app {
> +	enum mbim_app_type app_type;
> +	uint32_t aid_len;
> +	uint8_t *aid;
> +	char *label;
> +	uint32_t pin_key_references;
> +};
> +
>   struct sim_data {
>   	struct mbim_device *device;
> +	uint32_t app_count;
> +	uint32_t active_app;
> +	struct sim_app *apps;
>   	char *iccid;
>   	char *imsi;
>   	uint32_t last_pin_type;
>   	bool present : 1;
>   };
>   
> +static uint32_t mbim_file_structure_to_ofono(uint32_t file_structure)
> +{
> +	switch (file_structure) {
> +	case 1:
> +		return OFONO_SIM_FILE_STRUCTURE_TRANSPARENT;
> +	case 2:
> +		return OFONO_SIM_FILE_STRUCTURE_CYCLIC;
> +	case 3:
> +		return OFONO_SIM_FILE_STRUCTURE_FIXED;
> +	default:
> +		return OFONO_SIM_FILE_STRUCTURE_TRANSPARENT;
> +	}
> +}
> +
>   static void mbim_sim_state_changed(struct ofono_sim *sim, uint32_t ready_state)
>   {
>   	struct sim_data *sd = ofono_sim_get_data(sim);
> @@ -76,6 +101,136 @@ static void mbim_read_imsi(struct ofono_sim *sim,
>   	CALLBACK_WITH_SUCCESS(cb, sd->imsi, user_data);
>   }
>   
> +static void read_file_info_cb(struct mbim_message *message, void *user_data)
> +{
> +	struct cb_data *cbd = user_data;
> +	ofono_sim_file_info_cb_t cb = cbd->cb;
> +	unsigned char access[3] = {0x0f, 0xff, 0xff};
> +	uint32_t version, status_word1, status_word2, file_accessibility;
> +	uint32_t file_type, file_structure, file_item_count, file_item_size;
> +
> +	if (!mbim_message_get_error(message)) {
> +		mbim_message_get_arguments(message, "uuuuuuuu", &version, &status_word1,

This can fail, and the return value should be checked.


> +					&status_word2, &file_accessibility,
> +					&file_type, &file_structure,
> +					&file_item_count, &file_item_size);
> +
> +		CALLBACK_WITH_SUCCESS(cb, file_item_size,
> +					mbim_file_structure_to_ofono(file_structure),
> +					file_item_size * file_item_count,
> +					access, file_accessibility, cbd->data);
> +	} else {
> +		CALLBACK_WITH_FAILURE(cb, -1, -1, -1, NULL, -1, cbd->data);
> +	}
> +}
> +
> +static void mbim_read_file_info(struct ofono_sim *sim,
> +				int fileid, const unsigned char *path,
> +				unsigned int path_len,
> +				ofono_sim_file_info_cb_t cb, void *user_data)
> +{
> +	struct sim_data *data = ofono_sim_get_data(sim);
> +	struct cb_data *cbd = cb_data_new(cb, user_data);
> +	struct mbim_message *message;
> +	uint8_t *file_id_buf;
> +	int file_id_len;
> +
> +	message = mbim_message_new(mbim_ms_uicc_low_level_access,
> +					MBIM_CID_MS_UICC_LOW_LEVEL_ACCESS_FILE_STATUS,
> +					MBIM_COMMAND_TYPE_QUERY);
> +
> +	file_id_buf = mbim_get_fileid(data->apps[data->active_app].app_type, fileid, &file_id_len);
> +	mbim_message_set_arguments(message, "uayay", 1,
> +					data->apps[data->active_app].aid_len,
> +					data->apps[data->active_app].aid,
> +					file_id_len, file_id_buf);
> +	l_free(file_id_buf);
> +
> +	mbim_device_send(data->device, SIM_GROUP, message, read_file_info_cb, cbd, l_free);
> +}
> +
> +static void read_file_cb(struct mbim_message *message, void *user_data)
> +{
> +	struct cb_data *cbd = user_data;
> +	ofono_sim_read_cb_t cb = cbd->cb;
> +	struct mbim_message_iter iter;
> +	uint32_t version, status_word1, status_word2, data_size;
> +	uint8_t *data = NULL;
> +	int i = 0;
> +
> +	if (!mbim_message_get_error(message)) {
> +		mbim_message_get_arguments(message, "uuuAy", &version,

This can fail, and the return value should be checked.

> +						&status_word1, &status_word2, &iter);
> +
> +		data_size = iter.n_elem;
> +		data = l_malloc(data_size);
> +		while (mbim_message_iter_next_entry(&iter, data + i))
> +			i++;
> +
> +		CALLBACK_WITH_SUCCESS(cb, data, data_size, cbd->data);
> +	} else {
> +		CALLBACK_WITH_FAILURE(cb, NULL, 0, cbd->data);
> +	}
> +
> +	/* The data gets copied by ofono's sim driver, so we can free it */
> +	if (data)
> +		l_free(data);
> +}
> +
> +static void mbim_read_file_transparent(struct ofono_sim *sim,
> +					int fileid, int start, int length,
> +					const unsigned char *path, unsigned int path_len,
> +					ofono_sim_read_cb_t cb, void *user_data)
> +{
> +	struct sim_data *sd = ofono_sim_get_data(sim);
> +	struct cb_data *cbd = cb_data_new(cb, user_data);
> +	struct mbim_message *message;
> +	uint8_t *file_id_buf;
> +	int file_id_len;
> +
> +	message = mbim_message_new(mbim_ms_uicc_low_level_access,
> +					MBIM_CID_MS_UICC_LOW_LEVEL_ACCESS_READ_BINARY,
> +					MBIM_COMMAND_TYPE_QUERY);
> +
> +	file_id_buf = mbim_get_fileid(sd->apps[sd->active_app].app_type, fileid, &file_id_len);
> +	mbim_message_set_arguments(message, "uayayuusay", 1,
> +					sd->apps[sd->active_app].aid_len,
> +					sd->apps[sd->active_app].aid,
> +					file_id_len, file_id_buf, start,
> +					length, "", 0, NULL);
> +	l_free(file_id_buf);
> +
> +	mbim_device_send(sd->device, SIM_GROUP, message,
> +				read_file_cb, cbd, l_free);
> +}
> +
> +static void mbim_read_file_fixed_cyclic(struct ofono_sim *sim,
> +					int fileid, int record, int length,
> +					const unsigned char *path, unsigned int path_len,
> +					ofono_sim_read_cb_t cb, void *data)
> +{
> +	struct sim_data *sd = ofono_sim_get_data(sim);
> +	struct cb_data *cbd = cb_data_new(cb, data);
> +	struct mbim_message *message;
> +	uint8_t *file_id_buf;
> +	int file_id_len;
> +
> +	message = mbim_message_new(mbim_ms_uicc_low_level_access,
> +					MBIM_CID_MS_UICC_LOW_LEVEL_ACCESS_READ_RECORD,
> +					MBIM_COMMAND_TYPE_QUERY);
> +
> +	file_id_buf = mbim_get_fileid(sd->apps[sd->active_app].app_type, fileid, &file_id_len);
> +	mbim_message_set_arguments(message, "uayayusay", 1,
> +					sd->apps[sd->active_app].aid_len,
> +					sd->apps[sd->active_app].aid,
> +					file_id_len, file_id_buf, record,
> +					"", 0, NULL);
> +	l_free(file_id_buf);
> +
> +	mbim_device_send(sd->device, SIM_GROUP, message,
> +				read_file_cb, cbd, l_free);
> +}
> +
>   static enum ofono_sim_password_type mbim_pin_type_to_sim_password(
>   							uint32_t pin_type)
>   {
> @@ -473,6 +628,47 @@ error:
>   	ofono_sim_remove(sim);
>   }
>   
> +static void mbim_sim_list_apps_cb(struct mbim_message *message,
> +					void *user)
> +{
> +	struct sim_data *data = ofono_sim_get_data(user);
> +	uint32_t version, count, active_app;
> +	uint32_t application_id, size, pin_key_references;
> +	char *aid_label;
> +	struct mbim_message_iter iter, aid_iter, pin_iter;
> +	int i = 0;
> +

For correctness, set data->app_count = 0 and data->apps = NULL; here 
instead of below in the mbim_message_get_arguments() error path.

Then you can just return in the case of errors in the next two function 
calls.


> +	if (mbim_message_get_error(message))
> +		return;
> +
> +	if (!mbim_message_get_arguments(message, "uuuua(uAysuAy)", &version,
> +					&count, &active_app, &size, &iter)) {
> +		data->apps = NULL;
> +		data->app_count = 0;
> +		return;
> +	}

Oh, and one more thing; you might want to verify that count is a 
reasonable value (and return if > $bignumber. I don't know how often you 
might get nonsense from the sim, but.. Likewise, sanity checking for 
active_app (active_app < app_acount).


> +
> +	data->apps = l_new(struct sim_app, count);
> +	data->active_app = active_app;
> +	data->app_count = count;
> +

Personally I'd use a for loop here for clarity, but that's really up to 
you. But if you stick with the while() loop, I would set i=0 here to 
make it clearer what's going on.

> +	while (mbim_message_iter_next_entry(&iter, &application_id, &aid_iter,
> +					&aid_label, &pin_key_references, &pin_iter)) {
 > +		int j = 0;> +
> +		data->apps[i].app_type = application_id;
> +		data->apps[i].aid_len = aid_iter.n_elem;
> +		data->apps[i].aid = l_malloc(aid_iter.n_elem);


In the mbim_sim_remove function below, you free apps[i].label. But here 
you're getting label from the message_iter, and also allocating 
apps[i].aid but never free it. That's a bit confusing.. Did you mean to 
g_strdup(aid_label), and also l_free(sd->apps[i].aid) in the remove 
function below?


> +
> +		while (mbim_message_iter_next_entry(&aid_iter,
> +							data->apps[i].aid + j))
> +			j++;
> +
> +		data->apps[i].label = aid_label;
> +		i++;
> +	}
> +}
> +
>   static int mbim_sim_probe(struct ofono_sim *sim, unsigned int vendor,
>   				void *data)
>   {
> @@ -480,6 +676,14 @@ static int mbim_sim_probe(struct ofono_sim *sim, unsigned int vendor,
>   	struct mbim_message *message;
>   	struct sim_data *sd;
>   
> +	message = mbim_message_new(mbim_ms_uicc_low_level_access,
> +					MBIM_CID_MS_UICC_LOW_LEVEL_ACCESS_APPLICATION_LIST,
> +					MBIM_COMMAND_TYPE_QUERY);

For consistency, I would recommend verifying that message != NULL here 
as is done later in the function. It's a probe function, I'm guessing 
someone decided that it's a really good time to bail out if memory is tight.



> +	mbim_message_set_arguments(message, "");
> +
> +	mbim_device_send(device, SIM_GROUP, message,
> +			mbim_sim_list_apps_cb, sim, NULL);
> +
>   	message = mbim_message_new(mbim_uuid_basic_connect,
>   					MBIM_CID_SUBSCRIBER_READY_STATUS,
>   					MBIM_COMMAND_TYPE_QUERY);
> @@ -514,12 +718,22 @@ static void mbim_sim_remove(struct ofono_sim *sim)
>   
>   	l_free(sd->iccid);
>   	l_free(sd->imsi);
> +
> +	for (int i = 0; i < sd->app_count; i++)
> +		l_free(sd->apps[i].label);
> +
> +	l_free(sd->apps);
> +
>   	l_free(sd);
>   }
>   
>   static const struct ofono_sim_driver driver = {
>   	.probe			= mbim_sim_probe,
>   	.remove			= mbim_sim_remove,
> +	.read_file_info		= mbim_read_file_info,
> +	.read_file_transparent	= mbim_read_file_transparent,
> +	.read_file_cyclic	= mbim_read_file_fixed_cyclic,
> +	.read_file_linear	= mbim_read_file_fixed_cyclic,
>   	.read_imsi		= mbim_read_imsi,
>   	.query_passwd_state	= mbim_pin_query,
>   	.query_pin_retries	= mbim_pin_retries_query,
> diff --git a/drivers/mbimmodem/util.c b/drivers/mbimmodem/util.c
> index 4a3d9627..3280c863 100644
> --- a/drivers/mbimmodem/util.c
> +++ b/drivers/mbimmodem/util.c
> @@ -9,6 +9,7 @@
>   #include <stdbool.h>
>   
>   #include "src/common.h"
> +#include "simutil.h"
>   #include "mbim.h"
>   #include "util.h"
>   
> @@ -37,3 +38,33 @@ int mbim_data_class_to_tech(uint32_t n)
>   
>   	return -1;
>   }
> +
> +uint8_t *mbim_get_fileid(enum mbim_app_type app_type, uint32_t fileid, int *file_id_len)

Maybe mbim_get_fileid_path(), similar to isimodem's naming? Or 
mbim_get_fileid_path_new(), to make it clear that the returned memory 
should be freed by the caller?


> +{
> +	uint8_t parent_path[6] = {0};
> +	int fileid_len = 0;
> +	uint8_t *full_path;
> +
> +	if (app_type == MBIM_APP_USIM || app_type == MBIM_APP_ISIM)
> +		sim_ef_db_get_path_3g(fileid, parent_path);
> +	else
> +		sim_ef_db_get_path_2g(fileid, parent_path);


We should probably make sure sim_ef_db_get_path*() calls don't fail; if 
the result is < 2, I'm not sure what you should do.

> +
> +	/* Copy the parent_path up until the first pair of 0's */
> +	for (int i = 0; i < 6; i += 2) {
> +		if (i != 0 && parent_path[i] == 0x00

So you're always skipping over the first iteration of this loop? In that 
case, maybe start at 2 for clarity?  Eg,
		len = sim_ef_db_get_path_2g(...);

	if (len < 2 || len > 6) {
		/* set *file_id_len = -1 and return NULL?  set *file_id_len = 2, 
allocate an empty 2 byte full_path, fill it with fileid, and return it? */
	}

	for (i = 2; i < len; i += 2) {
		if (parent_path[i] == 0x0 && parent_path[i+1] == 0x0) {
			fileid_len = i;
			break;
		}
	}

> +			&& parent_path[i + 1] == 0x00) {
> +			fileid_len = i;
> +			break;
> +		}
> +	}
> +
> +	full_path = l_malloc(fileid_len + 2);
> +	memcpy(full_path, parent_path, fileid_len);
> +
> +	full_path[fileid_len] = (fileid >> 8) & 0xFF;
> +	full_path[fileid_len + 1] = fileid & 0xFF;
> +	*file_id_len = fileid_len + 2;
> +
> +	return full_path;
> +}
> diff --git a/drivers/mbimmodem/util.h b/drivers/mbimmodem/util.h
> index 2172cd9f..55669450 100644
> --- a/drivers/mbimmodem/util.h
> +++ b/drivers/mbimmodem/util.h
> @@ -43,3 +43,4 @@ static inline struct cb_data *cb_data_new(void *cb, void *data)
>   	} while (0)
>   
>   int mbim_data_class_to_tech(uint32_t n);
> +uint8_t *mbim_get_fileid(enum mbim_app_type app_type, uint32_t fileid, int *file_id_len);

