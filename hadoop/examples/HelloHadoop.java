package examples.hadoop.apache;

import java.io.IOException;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.LongWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.Mapper;
import org.apache.hadoop.mapreduce.Reducer;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;

public class HelloHadoop {

	static public class HelloMapper extends
			Mapper<LongWritable, Text, LongWritable, Text> {

		public void map(LongWritable key, Text value, Context context)
				throws IOException, InterruptedException {
			context.write((LongWritable) key, (Text) value);
		}
	}

	static public class HelloReducer extends
			Reducer<LongWritable, Text, LongWritable, Text> {
		public void reduce(LongWritable key, Iterable<Text> values,
				Context context) throws IOException, InterruptedException {
			Text val = new Text();
			for (Text str : values) {
				val.set(str.toString());
			}
			context.write(key, val);
		}
	}

	public static void main(String[] args) throws IOException,
			InterruptedException, ClassNotFoundException {
		Configuration conf = new Configuration();
		Job job = new Job(conf, "Hadoop Hello World");
		job.setJarByClass(HelloHadoop.class);
		FileInputFormat.setInputPaths(job, "/user/shunfa/input");
		FileOutputFormat
				.setOutputPath(job, new Path("/user/shunfa/output-hh1"));
		job.setMapperClass(HelloMapper.class);
		job.setReducerClass(HelloReducer.class);
		job.waitForCompletion(true);
	}
}
