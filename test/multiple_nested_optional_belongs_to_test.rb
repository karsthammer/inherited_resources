require File.expand_path('test_helper', File.dirname(__FILE__))

class Student; end
class Manager; end
class Employee; end

class Project
	def self.human_name; "Project"; end
end

class ProjectsController < InheritedResources::Base
	belongs_to :student, :manager, :employee, :optional => true
end

class MultipleNestedOptionalTest < ActionController::TestCase
	tests ProjectsController

	def setup
		@controller.stubs(:resource_url).returns('/')
		@controller.stubs(:collection_url).returns('/')
	end

	# INDEX
	def test_expose_all_projects_as_instance_variable_with_student
		Student.expects(:find).with('37').returns(mock_student)
		mock_student.expects(:projects).returns(Project)
		Project.expects(:scoped).returns([mock_project])
		get :index, :student_id => '37'
		assert_equal mock_student, assigns(:student)
		assert_equal [mock_project], assigns(:projects)
	end

	def test_expose_all_projects_as_instance_variable_with_manager
		Manager.expects(:find).with('38').returns(mock_manager)
		mock_manager.expects(:projects).returns(Project)
		Project.expects(:scoped).returns([mock_project])
		get :index, :manager_id => '38'
		assert_equal mock_manager, assigns(:manager)
		assert_equal [mock_project], assigns(:projects)
	end

	def test_expose_all_projects_as_instance_variable_with_employee
		Employee.expects(:find).with('666').returns(mock_employee)
		mock_employee.expects(:projects).returns(Project)
		Project.expects(:scoped).returns([mock_project])
		get :index, :employee_id => '666'
		assert_equal mock_employee, assigns(:employee)
		assert_equal [mock_project], assigns(:projects)
	end

	def test_expose_all_projects_as_instance_variable_with_manager_and_employee
		Manager.expects(:find).with('37').returns(mock_manager)
		mock_manager.expects(:employees).returns(Employee)
		Employee.expects(:find).with('42').returns(mock_employee)
		mock_employee.expects(:projects).returns(Project)
		Project.expects(:scoped).returns([mock_project])
		get :index, :manager_id => '37', :employee_id => '42'
		assert_equal mock_manager, assigns(:manager)
		assert_equal mock_employee, assigns(:employee)
		assert_equal [mock_project], assigns(:projects)
	end

	def test_expose_all_projects_as_instance_variable_without_parents
		Project.expects(:scoped).returns([mock_project])
		get :index
		assert_equal [mock_project], assigns(:projects)
	end

	# SHOW
	def test_expose_the_requested_project_with_student
		Student.expects(:find).with('37').returns(mock_student)
		mock_student.expects(:projects).returns(Project)
		Project.expects(:find).with('42').returns(mock_project)
		get :show, :id => '42', :student_id => '37'
		assert_equal mock_student, assigns(:student)
		assert_equal mock_project, assigns(:project)
	end

	def test_expose_the_requested_project_with_manager
		Manager.expects(:find).with('37').returns(mock_manager)
		mock_manager.expects(:projects).returns(Project)
		Project.expects(:find).with('42').returns(mock_project)
		get :show, :id => '42', :manager_id => '37'
		assert_equal mock_manager, assigns(:manager)
		assert_equal mock_project, assigns(:project)
	end

	def test_expose_the_requested_project_with_employee
		Employee.expects(:find).with('37').returns(mock_employee)
		mock_employee.expects(:projects).returns(Project)
		Project.expects(:find).with('42').returns(mock_project)
		get :show, :id => '42', :employee_id => '37'
		assert_equal mock_employee, assigns(:employee)
		assert_equal mock_project, assigns(:project)
	end

	def test_expose_the_requested_project_with_manager_and_employee
		Manager.expects(:find).with('37').returns(mock_manager)
		mock_manager.expects(:employees).returns(Employee)
		Employee.expects(:find).with('42').returns(mock_employee)
		mock_employee.expects(:projects).returns(Project)
		Project.expects(:find).with('13').returns(mock_project)
		get :show, :id => '13', :manager_id => '37', :employee_id => '42'
		assert_equal mock_manager, assigns(:manager)
		assert_equal mock_employee, assigns(:employee)
		assert_equal mock_project, assigns(:project)
	end

	def test_expose_the_requested_project_without_parents
		Project.expects(:find).with('13').returns(mock_project)
		get :show, :id => '13'
		assert_equal mock_project, assigns(:project)
	end

	# NEW
	def test_expose_a_new_project_with_student
		Student.expects(:find).with('37').returns(mock_student)
		mock_student.expects(:projects).returns(Project)
		Project.expects(:build).returns(mock_project)
		get :new, :student_id => '37'
		assert_equal mock_student, assigns(:student)
		assert_equal mock_project, assigns(:project)
	end

	def test_expose_a_new_project_with_manager
		Manager.expects(:find).with('37').returns(mock_manager)
		mock_manager.expects(:projects).returns(Project)
		Project.expects(:build).returns(mock_project)
		get :new, :manager_id => '37'
		assert_equal mock_manager, assigns(:manager)
		assert_equal mock_project, assigns(:project)
	end

	def test_expose_a_new_project_with_employee
		Employee.expects(:find).with('37').returns(mock_employee)
		mock_employee.expects(:projects).returns(Project)
		Project.expects(:build).returns(mock_project)
		get :new, :employee_id => '37'
		assert_equal mock_employee, assigns(:employee)
		assert_equal mock_project, assigns(:project)
	end

	def test_expose_a_new_project_with_manager_and_employee
		Manager.expects(:find).with('37').returns(mock_manager)
		mock_manager.expects(:employees).returns(Employee)
		Employee.expects(:find).with('42').returns(mock_employee)
		mock_employee.expects(:projects).returns(Project)
		Project.expects(:build).returns(mock_project)
		get :new, :manager_id => '37', :employee_id => '42'
		assert_equal mock_manager, assigns(:manager)
		assert_equal mock_employee, assigns(:employee)
		assert_equal mock_project, assigns(:project)
	end

	def test_expose_a_new_project_without_parents
		Project.expects(:new).returns(mock_project)
		get :new
		assert_equal mock_project, assigns(:project)
	end

	# EDIT
	def test_expose_the_requested_project_for_edition_with_student
		Student.expects(:find).with('37').returns(mock_student)
		mock_student.expects(:projects).returns(Project)
		Project.expects(:find).with('42').returns(mock_project)
		get :edit, :id => '42', :student_id => '37'
		assert_equal mock_student, assigns(:student)
		assert_equal mock_project, assigns(:project)
	end

	def test_expose_the_requested_project_for_edition_with_manager
		Manager.expects(:find).with('37').returns(mock_manager)
		mock_manager.expects(:projects).returns(Project)
		Project.expects(:find).with('42').returns(mock_project)
		get :edit, :id => '42', :manager_id => '37'
		assert_equal mock_manager, assigns(:manager)
		assert_equal mock_project, assigns(:project)
	end

	def test_expose_the_requested_project_for_edition_with_employee
		Employee.expects(:find).with('37').returns(mock_employee)
		mock_employee.expects(:projects).returns(Project)
		Project.expects(:find).with('42').returns(mock_project)
		get :edit, :id => '42', :employee_id => '37'
		assert_equal mock_employee, assigns(:employee)
		assert_equal mock_project, assigns(:project)
	end

	def test_expose_the_requested_project_for_edition_with_manager_and_employee
		Manager.expects(:find).with('37').returns(mock_manager)
		mock_manager.expects(:employees).returns(Employee)
		Employee.expects(:find).with('42').returns(mock_employee)
		mock_employee.expects(:projects).returns(Project)
		Project.expects(:find).with('13').returns(mock_project)
		get :edit, :id => '13', :manager_id => '37', :employee_id => '42'
		assert_equal mock_manager, assigns(:manager)
		assert_equal mock_employee, assigns(:employee)
		assert_equal mock_project, assigns(:project)
	end

	def test_expose_the_requested_project_for_edition_without_parents
		Project.expects(:find).with('13').returns(mock_project)
		get :edit, :id => '13'
		assert_equal mock_project, assigns(:project)
	end

	# CREATE
	def test_expose_a_newly_created_project_with_student
		Student.expects(:find).with('37').returns(mock_student)
		mock_student.expects(:projects).returns(Project)
		Project.expects(:build).with({ 'these' => 'params' }).returns(mock_project(:save => true))
		post :create, :student_id => '37', :project => { :these => 'params' }
		assert_equal mock_student, assigns(:student)
		assert_equal mock_project, assigns(:project)
	end

	def test_expose_a_newly_created_project_with_manager
		Manager.expects(:find).with('37').returns(mock_manager)
		mock_manager.expects(:projects).returns(Project)
		Project.expects(:build).with({ 'these' => 'params' }).returns(mock_project(:save => true))
		post :create, :manager_id => '37', :project => { :these => 'params' }
		assert_equal mock_manager, assigns(:manager)
		assert_equal mock_project, assigns(:project)
	end
	
	def test_expose_a_newly_created_project_with_employee
		Employee.expects(:find).with('37').returns(mock_employee)
		mock_employee.expects(:projects).returns(Project)
		Project.expects(:build).with({ 'these' => 'params' }).returns(mock_project(:save => true))
		post :create, :employee_id => '37', :project => { :these => 'params' }
		assert_equal mock_employee, assigns(:employee)
		assert_equal mock_project, assigns(:project)
	end

	def test_expose_a_newly_created_project_with_manager_and_employee
		Manager.expects(:find).with('37').returns(mock_manager)
		mock_manager.expects(:employees).returns(Employee)
		Employee.expects(:find).with('42').returns(mock_employee)
		mock_employee.expects(:projects).returns(Project)
		Project.expects(:build).with({ 'these' => 'params' }).returns(mock_project(:save => true))
		post :create, :manager_id => '37', :employee_id => '42', :project => { :these => 'params' }
		assert_equal mock_manager, assigns(:manager)
		assert_equal mock_employee, assigns(:employee)
		assert_equal mock_project, assigns(:project)
	end

	def test_expose_a_newly_created_project_without_parents
		Project.expects(:new).with({ 'these' => 'params' }).returns(mock_project(:save => true))
		post :create, :project => { :these => 'params' }
		assert_equal mock_project, assigns(:project)
	end

	# UPDATE
	def test_update_the_requested_project_with_student
		Student.expects(:find).with('37').returns(mock_student)
		mock_student.expects(:projects).returns(Project)
		Project.expects(:find).with('42').returns(mock_project)
		mock_project.expects(:update_attributes).with({ 'these' => 'params' }).returns(true)
		put :update, :id => '42', :student_id => '37', :project => { :these => 'params' }
		assert_equal mock_student, assigns(:student)
		assert_equal mock_project, assigns(:project)
	end

	def test_update_the_requested_project_with_manager
		Manager.expects(:find).with('37').returns(mock_manager)
		mock_manager.expects(:projects).returns(Project)
		Project.expects(:find).with('42').returns(mock_project)
		mock_project.expects(:update_attributes).with({ 'these' => 'params' }).returns(true)
		put :update, :id => '42', :manager_id => '37', :project => { :these => 'params' }
		assert_equal mock_manager, assigns(:manager)
		assert_equal mock_project, assigns(:project)
	end

	def test_update_the_requested_project_with_employee
		Employee.expects(:find).with('37').returns(mock_employee)
		mock_employee.expects(:projects).returns(Project)
		Project.expects(:find).with('42').returns(mock_project)
		mock_project.expects(:update_attributes).with({ 'these' => 'params' }).returns(true)
		put :update, :id => '42', :employee_id => '37', :project => { :these => 'params' }
		assert_equal mock_employee, assigns(:employee)
		assert_equal mock_project, assigns(:project)
	end

	def test_update_the_requested_project_with_manager_and_employee
		Manager.expects(:find).with('37').returns(mock_manager)
		mock_manager.expects(:employees).returns(Employee)
		Employee.expects(:find).with('13').returns(mock_employee)
		mock_employee.expects(:projects).returns(Project)
		Project.expects(:find).with('42').returns(mock_project)
		mock_project.expects(:update_attributes).with({ 'these' => 'params' }).returns(true)
		put :update, :id => '42', :manager_id => '37', :employee_id => '13', :project => { :these => 'params' }
		assert_equal mock_manager, assigns(:manager)
		assert_equal mock_employee, assigns(:employee)
		assert_equal mock_project, assigns(:project)
	end

	# DESTROY
	def test_the_requested_project_is_destroyed_with_student
		Student.expects(:find).with('37').returns(mock_student)
		mock_student.expects(:projects).returns(Project)
		Project.expects(:find).with('42').returns(mock_project)
		mock_project.expects(:destroy).returns(true)

		delete :destroy, :id => '42', :student_id => '37'
		assert_equal mock_student, assigns(:student)
		assert_equal mock_project, assigns(:project)
	end

	def test_the_requested_project_is_destroyed_with_manager
		Manager.expects(:find).with('37').returns(mock_manager)
		mock_manager.expects(:projects).returns(Project)
		Project.expects(:find).with('42').returns(mock_project)
		mock_project.expects(:destroy).returns(true)

		delete :destroy, :id => '42', :manager_id => '37'
		assert_equal mock_manager, assigns(:manager)
		assert_equal mock_project, assigns(:project)
	end

	def test_the_requested_project_is_destroyed_with_employee
		Employee.expects(:find).with('37').returns(mock_employee)
		mock_employee.expects(:projects).returns(Project)
		Project.expects(:find).with('42').returns(mock_project)
		mock_project.expects(:destroy).returns(true)

		delete :destroy, :id => '42', :employee_id => '37'
		assert_equal mock_employee, assigns(:employee)
		assert_equal mock_project, assigns(:project)
	end

	def test_the_requested_project_is_destroyed_with_manager_and_employee
		Manager.expects(:find).with('37').returns(mock_manager)
		mock_manager.expects(:employees).returns(Employee)
		Employee.expects(:find).with('13').returns(mock_employee)
		mock_employee.expects(:projects).returns(Project)
		Project.expects(:find).with('42').returns(mock_project)
		mock_project.expects(:destroy).returns(true)

		delete :destroy, :id => '42', :manager_id => '37', :employee_id => '13'
		assert_equal mock_manager, assigns(:manager)
		assert_equal mock_employee, assigns(:employee)
		assert_equal mock_project, assigns(:project)
	end

	def test_the_requested_project_is_destroyed_without_parents
		Project.expects(:find).with('42').returns(mock_project)
		mock_project.expects(:destroy).returns(true)

		delete :destroy, :id => '42'
		assert_equal mock_project, assigns(:project)
	end

	protected
	def mock_manager(stubs={})
		@mock_manager ||= mock(stubs)
	end

	def mock_employee(stubs={})
		@mock_employee ||= mock(stubs)
	end

	def mock_student(stubs={})
		@mock_student ||= mock(stubs)
	end

	def mock_project(stubs={})
		@mock_project ||= mock(stubs)
	end
end
# 
# 
# 
# class Brands; end
# class Category; end
# class Product
#   def self.human_name; 'Product'; end
# end
# 
# class ProductsController < InheritedResources::Base
#   belongs_to :brand, :category, :polymorphic => true, :optional => true
# end
# 
# class OptionalTest < ActionController::TestCase
#   tests ProductsController
# 
#   def setup
#     @controller.stubs(:resource_url).returns('/')
#     @controller.stubs(:collection_url).returns('/')
#   end
# 
#   def test_expose_all_products_as_instance_variable_with_category
#     Category.expects(:find).with('37').returns(mock_category)
#     mock_category.expects(:products).returns(Product)
#     Product.expects(:scoped).returns([mock_product])
#     get :index, :category_id => '37'
#     assert_equal mock_category, assigns(:category)
#     assert_equal [mock_product], assigns(:products)
#   end
# 
#   def test_expose_all_products_as_instance_variable_without_category
#     Product.expects(:scoped).returns([mock_product])
#     get :index
#     assert_equal nil, assigns(:category)
#     assert_equal [mock_product], assigns(:products)
#   end
# 
#   def test_expose_the_requested_product_with_category
#     Category.expects(:find).with('37').returns(mock_category)
#     mock_category.expects(:products).returns(Product)
#     Product.expects(:find).with('42').returns(mock_product)
#     get :show, :id => '42', :category_id => '37'
#     assert_equal mock_category, assigns(:category)
#     assert_equal mock_product, assigns(:product)
#   end
# 
#   def test_expose_the_requested_product_without_category
#     Product.expects(:find).with('42').returns(mock_product)
#     get :show, :id => '42'
#     assert_equal nil, assigns(:category)
#     assert_equal mock_product, assigns(:product)
#   end
# 
#   def test_expose_a_new_product_with_category
#     Category.expects(:find).with('37').returns(mock_category)
#     mock_category.expects(:products).returns(Product)
#     Product.expects(:build).returns(mock_product)
#     get :new, :category_id => '37'
#     assert_equal mock_category, assigns(:category)
#     assert_equal mock_product, assigns(:product)
#   end
# 
#   def test_expose_a_new_product_without_category
#     Product.expects(:new).returns(mock_product)
#     get :new
#     assert_equal nil, assigns(:category)
#     assert_equal mock_product, assigns(:product)
#   end
# 
#   def test_expose_the_requested_product_for_edition_with_category
#     Category.expects(:find).with('37').returns(mock_category)
#     mock_category.expects(:products).returns(Product)
#     Product.expects(:find).with('42').returns(mock_product)
#     get :edit, :id => '42', :category_id => '37'
#     assert_equal mock_category, assigns(:category)
#     assert_equal mock_product, assigns(:product)
#   end
# 
#   def test_expose_the_requested_product_for_edition_without_category
#     Product.expects(:find).with('42').returns(mock_product)
#     get :edit, :id => '42'
#     assert_equal nil, assigns(:category)
#     assert_equal mock_product, assigns(:product)
#   end
# 
7# 
#   def test_expose_a_newly_create_product_without_category
#     Product.expects(:new).with({'these' => 'params'}).returns(mock_product(:save => true))
#     post :create, :product => {:these => 'params'}
#     assert_equal nil, assigns(:category)
#     assert_equal mock_product, assigns(:product)
#   end
# 
#   def test_update_the_requested_object_with_category
#     Category.expects(:find).with('37').returns(mock_category)
#     mock_category.expects(:products).returns(Product)
#     Product.expects(:find).with('42').returns(mock_product)
#     mock_product.expects(:update_attributes).with({'these' => 'params'}).returns(true)
# 
#     put :update, :id => '42', :category_id => '37', :product => {:these => 'params'}
#     assert_equal mock_category, assigns(:category)
#     assert_equal mock_product, assigns(:product)
#   end
# 
#   def test_update_the_requested_object_without_category
#     Product.expects(:find).with('42').returns(mock_product)
#     mock_product.expects(:update_attributes).with({'these' => 'params'}).returns(true)
# 
#     put :update, :id => '42', :product => {:these => 'params'}
#     assert_equal nil, assigns(:category)
#     assert_equal mock_product, assigns(:product)
#   end
# 
#   def test_the_requested_product_is_destroyed_with_category
#     Category.expects(:find).with('37').returns(mock_category)
#     mock_category.expects(:products).returns(Product)
#     Product.expects(:find).with('42').returns(mock_product)
#     mock_product.expects(:destroy).returns(true)
#     @controller.expects(:collection_url).returns('/')
# 
#     delete :destroy, :id => '42', :category_id => '37'
#     assert_equal mock_category, assigns(:category)
#     assert_equal mock_product, assigns(:product)
#   end
# 
#   def test_the_requested_product_is_destroyed_without_category
#     Product.expects(:find).with('42').returns(mock_product)
#     mock_product.expects(:destroy).returns(true)
#     @controller.expects(:collection_url).returns('/')
# 
#     delete :destroy, :id => '42'
#     assert_equal nil, assigns(:category)
#     assert_equal mock_product, assigns(:product)
#   end
# 
#   def test_polymorphic_helpers
#     Product.expects(:scoped).returns([mock_product])
#     get :index
# 
#     assert !@controller.send(:parent?)
#     assert_equal nil, assigns(:parent_type)
#     assert_equal nil, @controller.send(:parent_type)
#     assert_equal nil, @controller.send(:parent_class)
#     assert_equal nil, assigns(:category)
#     assert_equal nil, @controller.send(:parent)
#   end
# 
#   protected
#     def mock_category(stubs={})
#       @mock_category ||= mock(stubs)
#     end
# 
#     def mock_product(stubs={})
#       @mock_product ||= mock(stubs)
#     end
# end
